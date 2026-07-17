#include<stdio.h>

struct Podaci{
    char a;
    int b;
    char c;
};
#pragma pack(1)
struct Podaci1{
    char a;
    int b;
    char c;
};

int main(){
    printf("Velicina strukture %i\n", sizeof(struct Podaci));
    printf("Velicina strukture %i\n", sizeof(struct Podaci1));
    return 0;
}