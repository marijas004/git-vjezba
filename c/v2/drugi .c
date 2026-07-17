#include<stdio.h>
#define SIZE 6
typedef struct{
    int data[SIZE];
    int write_index;
    int read_index;
    int count;
} KruzniBafer;

void initBafer(KruzniBafer *kb){
    kb->write_index=0;
    kb->read_index=0;
    kb->count=0;
}
int isFull(KruzniBafer* kb){
    if(kb->count==SIZE){
        return 1;
    }
    return 0;
}
int isEmpty(KruzniBafer* kb){
    if(kb->count==0){
        return 1;
    }
    return 0;
}
int readEl(KruzniBafer* kb){
    if(isEmpty(kb)){
        printf("Bafer je prazan\n");
        return -1;
    }
    int podatak=kb->data[kb->read_index];
    kb->read_index=(kb->read_index+1)%SIZE;
    kb->count-=1;

    return podatak;
}

int writeEl(KruzniBafer* kb, int el){
    if(kb->count==SIZE){
        printf("Bafer je pun i nije moguce dodavati jos elemenata\n");
        return 0;
    }
    kb->data[kb->write_index]=el;
    kb->write_index=(kb->write_index+1)% SIZE;
    kb->count+=1;
    return 1;
}

int main(){
    KruzniBafer kb;
    initBafer(&kb);
    readEl(&kb);
    for(int i=0;i<7;i++){
        printf("Upisivanje %d elementa u bafer\n", i);
        writeEl(&kb,i);
    }
    for(int i=0;i<10;i++){
        printf("Brisanje %d elementa iz bafera\n", i);
        readEl(&kb);
    }
    return 0;
}