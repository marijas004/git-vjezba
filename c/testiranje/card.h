#ifndef CARD_H
#define CARD_H

#include <stdio.h>
#include <ctype.h>
#include <string.h>

typedef struct {
    char number_card[16];
    double state;
    double maxC;
    double minC;
} Card;

int validateCard(Card *c);
int getCash(double num, Card *c);
int putCash(double num, Card *c);

#endif