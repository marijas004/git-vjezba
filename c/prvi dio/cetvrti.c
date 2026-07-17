#include<stdio.h>

struct statusWindow{
    unsigned int open: 1;
    unsigned int LoRetna: 1;
    unsigned int light: 3;
    unsigned int dampness: 7;
};

int main(){
    struct statusWindow win={1,2,3,25};
    printf("Status prozora je\n"
       "Otvoren: %s\n"
       "Roletna: %s\n"
       "Jacina svjetlosti: %u\n"
       "Vlaga: %u\n",
       win.open ? "otvoren" : "zatvoren",
       win.LoRetna ? "spustena" : "dignuta",
       win.light,
       win.dampness);
}