#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#define ALGORITAM_GREYSCALE 1
#define ALGORITAM_MEAN 2
#define ODABRANI_ALG ALGORITAM_MEAN

/*— ensure no struct padding —*/
#pragma pack(push, 1)
typedef struct
{
    uint16_t bfType;      // must be 'BM' = 0x4D42
    uint32_t bfSize;      // file size in bytes
    uint16_t bfReserved1; // =0
    uint16_t bfReserved2; // =0
    uint32_t bfOffBits;   // offset to pixel data
} BITMAPFILEHEADER;

typedef struct
{
    uint32_t biSize;         // size of this header (40)
    int32_t biWidth;         // image width
    int32_t biHeight;        // image height (positive = bottom-up)
    uint16_t biPlanes;       // must be 1
    uint16_t biBitCount;     // bits per pixel (we expect 24)
    uint32_t biCompression;  // 0 = BI_RGB (no compression)
    uint32_t biSizeImage;    // image data size (including padding)
    int32_t biXPelsPerMeter; // resolution
    int32_t biYPelsPerMeter;
    uint32_t biClrUsed; // palette entries (0 for true color)
    uint32_t biClrImportant;
} BITMAPINFOHEADER;
#pragma pack(pop)

/**
 * load_bmp:
 *   filename: path to .bmp
 *   outWidth, outHeight: filled with dims
 *   returns: pointer to malloc'ed buffer [width*height*3] in RGB order,
 *            or NULL on error. Free with free().
 */
unsigned char *load_bmp(const char *filename, int *outWidth, int *outHeight)
{
    FILE *f = fopen(filename, "rb");
    if (!f)
    {
        perror("fopen");
        return NULL;
    }

    BITMAPFILEHEADER bfh;
    BITMAPINFOHEADER bih;
    if (fread(&bfh, sizeof bfh, 1, f) != 1 ||
        fread(&bih, sizeof bih, 1, f) != 1)
    {
        fprintf(stderr, "Failed to read BMP headers\n");
        fclose(f);
        return NULL;
    }

    if (bfh.bfType != 0x4D42 || bih.biBitCount != 24 || bih.biCompression != 0)
    {
        fprintf(stderr, "Unsupported BMP format (only uncompressed 24bpp)\n");
        fclose(f);
        return NULL;
    }

    int w = bih.biWidth;
    int h = abs(bih.biHeight);
    int row_bytes = ((w * 3 + 3) / 4) * 4; // padded to 4 bytes
    unsigned char *data = malloc(w * h * 3);
    if (!data)
    {
        perror("malloc");
        fclose(f);
        return NULL;
    }

    fseek(f, bfh.bfOffBits, SEEK_SET);
    for (int y = 0; y < h; y++)
    {
        // BMP stores bottom row first if biHeight>0
        int row = (bih.biHeight > 0) ? (h - 1 - y) : y;
        unsigned char *ptr = data + (row * w * 3);
        unsigned char *scan = malloc(row_bytes);
        if (!scan)
        {
            perror("malloc");
            free(data);
            fclose(f);
            return NULL;
        }
        if (fread(scan, 1, row_bytes, f) != (size_t)row_bytes)
        {
            fprintf(stderr, "Failed to read BMP scanline\n");
            free(scan);
            free(data);
            fclose(f);
            return NULL;
        }
        // BGR -> RGB
        for (int x = 0; x < w; x++)
        {
            ptr[3 * x + 0] = scan[3 * x + 2];
            ptr[3 * x + 1] = scan[3 * x + 1];
            ptr[3 * x + 2] = scan[3 * x + 0];
        }
        free(scan);
    }

    fclose(f);
    *outWidth = w;
    *outHeight = h;
    return data;
}
/**
 * write_bmp:
 *   filename: output path
 *   data:     RGB buffer [w*h*3]
 *   w, h:     dims
 * returns 0 on success, -1 on error
 */
int write_bmp(const char *filename,
              const unsigned char *data,
              int w, int h)
{
    int row_bytes = ((w * 3 + 3) / 4) * 4;
    uint32_t imageSize = row_bytes * h;
    BITMAPFILEHEADER bfh = {
        .bfType = 0x4D42,
        .bfSize = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER) + imageSize,
        .bfReserved1 = 0,
        .bfReserved2 = 0,
        .bfOffBits = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER)};
    BITMAPINFOHEADER bih = {
        .biSize = sizeof(BITMAPINFOHEADER),
        .biWidth = w,
        .biHeight = h, // positive = bottom-up
        .biPlanes = 1,
        .biBitCount = 24,
        .biCompression = 0,
        .biSizeImage = imageSize,
        .biXPelsPerMeter = 2835, // 72 DPI
        .biYPelsPerMeter = 2835,
        .biClrUsed = 0,
        .biClrImportant = 0};

    FILE *f = fopen(filename, "wb");
    if (!f)
    {
        perror("fopen");
        return -1;
    }

    if (fwrite(&bfh, sizeof bfh, 1, f) != 1 ||
        fwrite(&bih, sizeof bih, 1, f) != 1)
    {
        fprintf(stderr, "Failed to write BMP headers\n");
        fclose(f);
        return -1;
    }

    unsigned char *scan = malloc(row_bytes);
    if (!scan)
    {
        perror("malloc");
        fclose(f);
        return -1;
    }

    for (int y = 0; y < h; y++)
    {
        int row = h - 1 - y; 
        const unsigned char *ptr = data + (row * w * 3);

        for (int x = 0; x < w; x++)
        {
            scan[3 * x + 0] = ptr[3 * x + 2];
            scan[3 * x + 1] = ptr[3 * x + 1];
            scan[3 * x + 2] = ptr[3 * x + 0];
        }
        for (int p = 3 * w; p < row_bytes; p++)
            scan[p] = 0;
        fwrite(scan, 1, row_bytes, f);
    }

    free(scan);
    fclose(f);
    return 0;
}
#if ODABRANI_ALG == ALGORITAM_GREYSCALE
unsigned char *convert_grayscale(const char *filename, int *outWidth, int *outHeight)
{
    FILE *f = fopen(filename, "rb");
    if (!f)
    {
        perror("fopen");
        return NULL;
    }

    BITMAPFILEHEADER bfh;
    BITMAPINFOHEADER bih;
    if (fread(&bfh, sizeof bfh, 1, f) != 1 ||
        fread(&bih, sizeof bih, 1, f) != 1)
    {
        fprintf(stderr, "Failed to read BMP headers\n");
        fclose(f);
        return NULL;
    }

    if (bfh.bfType != 0x4D42 || bih.biBitCount != 24 || bih.biCompression != 0)
    {
        fprintf(stderr, "Unsupported BMP format (only uncompressed 24bpp)\n");
        fclose(f);
        return NULL;
    }

    int w = bih.biWidth;
    int h = abs(bih.biHeight);
    int row_bytes = ((w * 3 + 3) / 4) * 4; // padded to 4 bytes
    unsigned char *data = malloc(w * h * 3);
    if (!data)
    {
        perror("malloc");
        fclose(f);
        return NULL;
    }

    fseek(f, bfh.bfOffBits, SEEK_SET);
    for (int y = 0; y < h; y++)
    {
        // BMP stores bottom row first if biHeight>0
        int row = (bih.biHeight > 0) ? (h - 1 - y) : y;
        unsigned char *ptr = data + (row * w * 3);
        unsigned char *scan = malloc(row_bytes);
        if (!scan)
        {
            perror("malloc");
            free(data);
            fclose(f);
            return NULL;
        }
        if (fread(scan, 1, row_bytes, f) != (size_t)row_bytes)
        {
            fprintf(stderr, "Failed to read BMP scanline\n");
            free(scan);
            free(data);
            fclose(f);
            return NULL;
        }
        // BGR -> RGB
        for (int x = 0; x < w; x++)
        {
            unsigned char r = scan[3 * x + 0];
            unsigned char g = scan[3 * x + 1];
            unsigned char b = scan[3 * x + 2];

            unsigned char grey = r * 0.3 + g * 0.5 + b * 0.1;

            ptr[3 * x + 0] = grey;
            ptr[3 * x + 1] = grey;
            ptr[3 * x + 2] = grey;
        }
        free(scan);
    }

    fclose(f);
    *outWidth = w;
    *outHeight = h;
    return data;
}
#elif ODABRANI_ALG == ALGORITAM_MEAN
unsigned char *mean_filter(const char *filename, int *outWidth, int *outHeight)
{
    unsigned char *data = load_bmp(filename, outWidth, outHeight);
    if (!data) return NULL;

    int w = *outWidth;
    int h = *outHeight;

    unsigned char *output_data = malloc(w * h * 3);
    if (!output_data)
    {
        perror("malloc za output sliku");
        free(data);
        return NULL;
    }
    memcpy(output_data, data, w * h * 3);

    for (int y = 1; y < h - 1; y++)
    {
        for (int x = 1; x < w - 1; x++)
        {
            int sum_r = 0, sum_g = 0, sum_b = 0;

            for (int ky = -1; ky <= 1; ky++)
            {
                for (int kx = -1; kx <= 1; kx++)
                {
                    int pixel_index = ((y + ky) * w + (x + kx)) * 3;
                    sum_r += data[pixel_index + 0];
                    sum_g += data[pixel_index + 1];
                    sum_b += data[pixel_index + 2];
                }
            }

            int dest_index = (y * w + x) * 3;
            output_data[dest_index + 0] = (unsigned char)(sum_r / 9);
            output_data[dest_index + 1] = (unsigned char)(sum_g / 9);
            output_data[dest_index + 2] = (unsigned char)(sum_b / 9);
        }
    }

    free(data); 
    return output_data; 
}
#else
#error "Greska: Niste izabrali validan algoritam!"
#endif

int main(int argc, char *argv[])
{
    int w, h;
    const char *putanja_do_slike = "C:/Users/Student/Desktop/skola/c/v2/Image.bmp";
    unsigned char *obradjena_slika = NULL;
    const char *putanja_izlaz = NULL;

    printf("Pokusavam ucitati sliku sa putanje: %s...\n", putanja_do_slike);

    #if ODABRANI_ALG == ALGORITAM_GREYSCALE
        printf("[MOD: Greyscale] Obrada u toku...\n");
        obradjena_slika = convert_grayscale(putanja_do_slike, &w, &h);
        putanja_izlaz = "C:/Users/Student/Desktop/skola/c/v2/Image_siva.bmp";
        
    #elif ODABRANI_ALG == ALGORITAM_MEAN
        printf("[MOD: Mean Filter] Obrada u toku...\n");
        obradjena_slika = mean_filter(putanja_do_slike, &w, &h); 
        putanja_izlaz = "C:/Users/Student/Desktop/skola/c/v2/Image_filtrirana.bmp";
    #endif

    if (!obradjena_slika)
    {
        printf("\nGreska: Program ne moze otvoriti ili obraditi sliku!\n");
        return 1;
    }

    printf("Slika uspjesno ucitana i obradjena! Dimenzije: %d x %d px.\n", w, h);

    if (write_bmp(putanja_izlaz, obradjena_slika, w, h) != 0)
    {
        fprintf(stderr, "Greska pri upisivanju izlazne slike!\n");
        free(obradjena_slika);
        return 1;
    }

    free(obradjena_slika);
    printf("Uspjeh! Nova slika sacuvana na: %s\n", putanja_izlaz);

    return 0;
}
