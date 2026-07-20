#include "card.h"

int validateCard(Card *c){
    int sum = 0;

    if(strlen(c->number_card) != 13){
        printf("Pogresan broj kartice (nema 13 karaktera)\n");
        return 0;
    }

    for(int i = 0; i < 13; i++){
        if(isdigit(c->number_card[i])){
            sum += c->number_card[i]- '0';
        }else{
            printf("Greska, jedan od karaktera nije broj!\n");
            return 0;
        }
    }

    if(sum % 3 != 0){
        printf("DEBUG: sum = %d, ulazim u nonValid granu\n", sum);
        printf("Greska, broj kartice nije validan (zbir nije djeljiv sa 3)\n");
        return 0;
    }

    return 1;
}

int getCash(double num, Card *c){
    if(((int)num % 10) != 0){
        printf("Greska, dozvoljeno je podizanje novca po 10,20 i 50 (bez sitnih kovanica)");
        return 0;
    }

    if(num > c->maxC || num < c->minC){
        printf("Greska, pokusaj podizanja vise ili manje novca od dozvoljenog");
        return 0;
    }

    if(c->state < num){
        printf("Greska, nema dovoljno stanja na racunu");
        return 0;
    }

    c->state -= num;
    printf("Uspjesno ste skinuli novac sa racuna, stanje: %.2f\n", c->state);
    return 1;
}

int putCash(double num, Card *c){
    if(((int)num % 10) != 0){
        printf("Greska, dozvoljeno je polaganje novca po 10,20 i 50 (bez sitnih kovanica)");
        return 0;
    }

    if(num > c->maxC || num < c->minC){
        printf("Greska, pokusaj polaganja vise ili manje novca od dozvoljenog");
        return 0;
    }

    c->state += num;
    printf("Uspjesno ste polozili novac na racun, stanje: %.2f\n", c->state);
    return 1;
}