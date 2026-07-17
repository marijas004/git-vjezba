#include <stdio.h>

int globalna;

int promjeni(int vrijednost){
    globalna=vrijednost;
    return globalna;
}

int main(){
    return 0;
}