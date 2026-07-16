#include<stdio.h>
#include <string.h>

int jePalindrom(char s[],int n){
    for(int i=0;i<n;i++){
        if(s[i] != s[n-1-i]){
            return 0;
        }
    }
    return 1;
}

int main(){
    char s[]="mjaajm";
    int n=strlen(s);
    printf("Rijec %s ", s);
    if(jePalindrom(s,n)==1){
        printf("je palindrom");
    }else{
        printf("nije palindrom");
    }

}