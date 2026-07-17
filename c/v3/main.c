#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "ceasar.h"

int main(){
    const char *input="ovojeporuka";
    char output[50] = {0};
    int_fast16_t shift=4;

    printf("pozivamo funkciju za enkripciju\n");
    encryptCeasar(input, output, shift);
    printf("enkriptovana rijec: %s\n\n", output);

    char decrypted[50] = {0};
    printf("pozivamo funkciju za dekripciju\n");
    decryptCeasar(output, decrypted, shift);
    printf("dekriptovana rijec: %s\n", decrypted);
    
    return 0;
}

