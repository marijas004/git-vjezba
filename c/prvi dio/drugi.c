#include<stdarg.h>
#include<stdio.h>

double pronadji_max(int broj_arg, ...){
    va_list args;
    double max = 0.0;
    va_start(args,broj_arg);
    for(int i=0;i<broj_arg;i++){
        double temp=va_arg(args, double);
        if(temp>max){
            max=temp;
        }
    }
    va_end(args);
    return max;
}

int main(){
    double najveci= pronadji_max(5, 32.3, 43.2,2.2,55.4,4.0);
    printf("Najveci broj je %f\n", najveci);
    return 0;
}