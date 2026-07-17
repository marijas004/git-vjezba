#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct person
{
    int id;
    char name[25];
    int age;
};

typedef struct person person;

struct node
{
    struct person data;
    struct node *next;
};

typedef struct node node;

node* head = NULL;


node* insertAtBegining(node* head, person p){
    node* new_node = (node*)malloc(sizeof(node));
    if(new_node == NULL){
        printf("Greska\n");
        return head;
    }
    new_node->data = p;
    new_node->next = head;
    head = new_node;
    return head;
}

node* instertAtIndex(node* prev_node, person p){
    if (prev_node == NULL) {
        printf("Prethodni cvor ne moze biti NULL!\n");
        return NULL;
    }
    node* new_node = (node*)malloc(sizeof(node));
    if(new_node == NULL){
        printf("Greska\n");
        return NULL;
    }
    new_node->data = p;
    new_node->next = prev_node->next;
    prev_node->next = new_node;
    return new_node;
}

node* insertAtEnd(node* tail, person p){
    node* new_node = (node*)malloc(sizeof(node));
    if(new_node == NULL){
        printf("Greska\n");
        return NULL;
    }
    new_node->data = p;
    new_node->next = NULL;

    if (tail != NULL) {
        tail->next = new_node;
    }
    return new_node;
}

node* findEl(int index, node* head){
    node* tmp = head;
    while(tmp != NULL){
        if(tmp->data.id == index){
            return tmp;
        }
        tmp = tmp->next;
    }
    printf("Osoba sa id %d nije pronadjena u listi\n", index);
    return NULL;
}

void forEach(node *head){
    if (head == NULL) {
        printf("Lista je prazna.\n");
        return;
    }
    node *tmp = head;
    while(tmp != NULL){
        printf("Cvor id: %d, %s, godine: %d\n", tmp->data.id, tmp->data.name, tmp->data.age);
        tmp = tmp->next;
    }
}

int main(int argc, char* argv[])
{
    person p1 = {1, "Marko", 23};
    person p2 = {2, "Ana", 19};
    person p3 = {3, "Jovan", 30};
    person p4 = {4, "Marija", 25};

    head = insertAtBegining(head, p1); 
    head = insertAtBegining(head, p2); 
    forEach(head);
    printf("\n");
    node* tail = head;
    while(tail->next != NULL) {
        tail = tail->next;
    }
    tail = insertAtEnd(tail, p3); 
    forEach(head);
    printf("\n");

    printf("Testiranje: Pronalazenje elementa (ID: 1) ---\n");
    node* nadjen = findEl(1, head); 
    if(nadjen != NULL) {
        printf("Pronadjen: %s\n", nadjen->data.name);
    }
    printf("\n");

    printf("Testiranje: Unos na specificno mjesto (nakon nadjenog) ---\n");
    if(nadjen != NULL) {
        instertAtIndex(nadjen, p4); 
    }
    forEach(head);
    printf("\n");

    printf("Testiranje: Pretraga nepostojeceg ID-a ---\n");
    findEl(99, head);
    printf("\n");

    node* tmp;
    while (head != NULL) {
        tmp = head;
        head = head->next;
        free(tmp);
    }

    return 0;
}