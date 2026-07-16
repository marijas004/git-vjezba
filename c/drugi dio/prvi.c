#include<stdio.h>

void rotirajNiz(int niz[], int n,int d){
    int niz1[n];
    for(int i=0;i<n;i++){
        if(i-d<0){
            int index=n-(d-i);
            niz1[index]=niz[i];
        }else{
            int index=i-d;
            niz1[index]=niz[i];
        }
    }
    for(int i=0;i<n;i++){
        niz[i]=niz1[i];
    }
}

int main(){
    int niz[]={1,2,3,4,5,6,7,8};
    int n= sizeof(niz)/sizeof(niz[0]);

    rotirajNiz(niz, n,4);
    printf("Niz:\n");
    for (int i = 0; i < n; i++) {
        printf("%d ", niz[i]);
    }

    return 0;
}