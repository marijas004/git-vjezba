#include<stdio.h>

struct Node{
    int id;
    struct Node *ptr;
};

void dodaj(struct Node **rear, int vrijednost){
    struct Node *novi = malloc(sizeof(struct Node));

    novi->id = vrijednost;

}

int main(){

}