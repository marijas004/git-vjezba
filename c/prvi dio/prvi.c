#include<stdio.h>

static int brojac=0;
void brojac_poziva(){
    brojac+=1;
    printf("Funkcija je pozvana %i. put\n", brojac);
}

int main(){
    for(int i=0;i<3;i++){
        brojac_poziva();
    }
}