#include<stdio.h>
#include "unity.h"
#include "card.h"
#include <string.h>
void setUp(void){

}
void tearDown(void){

}
void test_validateCard_valid(void){
    Card c = {
        "1111111111113",
        100.00,
        500.00,
        10.00
    };
    TEST_ASSERT_EQUAL_INT(1, validateCard(&c));
}
void test_validateCard_invalidLength(void){
    Card c = {
        "123",
        100.00,
        500.00,
        10.00
    };
    TEST_ASSERT_EQUAL_INT(0, validateCard(&c));
}
void test_validateCard_containsLetter(void){
    Card c = {
        "111111111111A",
        100.00,
        500.00,
        10.00
    };
    printf("length = %d\n", strlen(c.number_card));
    printf("DEBUG: rezultat containsLetter = %d\n", validateCard(&c));
    TEST_ASSERT_EQUAL_INT(0, validateCard(&c));
}
void test_validateCard_nonValid(void){
    Card c = {
        "1111111111112",
        100.00,
        500.00,
        10.00
    };
    printf("length = %d\n", strlen(c.number_card));
    TEST_ASSERT_EQUAL_INT(0, validateCard(&c));
}
void test_getCash_invalidNumber(void){
    Card c = {
        "1111111111111",
        100.00,
        500.00,
        10.00
    };
    TEST_ASSERT_EQUAL_INT(0, getCash(15.0,&c));
}
void test_getCash_minNumber(void){
    Card c = {
        "1111111111111",
        100.00,
        500.00,
        20.00
    };
    TEST_ASSERT_EQUAL_INT(0, getCash(10.0,&c));
}
void test_getCash_notEnoughMoney(void){
    Card c = {
        "1111111111111",
        100.00,
        500.00,
        10.00
    };
    TEST_ASSERT_EQUAL_INT(0, getCash(110.0,&c));
}

void test_getCash_valid(void){
    Card c = {
        "1111111111111",
        100.00,
        500.00,
        10.00
    };
    TEST_ASSERT_EQUAL_INT(1, getCash(20.0,&c));
    TEST_ASSERT_EQUAL_FLOAT(80.0f, (float)c.state);
}
void test_putCash_valid(void){
    Card c = {
        "1111111111111",
        100.00,
        500.00,
        10.00
    };
    TEST_ASSERT_EQUAL_INT(1, putCash(20.0,&c));
    TEST_ASSERT_EQUAL_FLOAT(120.0f, (float)c.state);
}
void test_putCash_invalidNumber(void){
    Card c = {
        "1111111111111",
        100.00,
        500.00,
        10.00
    };
    TEST_ASSERT_EQUAL_INT(0, putCash(15.0,&c));
}
void test_putCash_minNumber(void){
    Card c = {
        "1111111111111",
        100.00,
        500.00,
        10.00
    };
    TEST_ASSERT_EQUAL_INT(0, putCash(5.0,&c));
}
void test_putCash_maxNumber(void){
    Card c = {
        "1111111111111",
        100.00,
        500.00,
        10.00
    };
    TEST_ASSERT_EQUAL_INT(0, putCash(510.0,&c));
}
int main(void)
{
    UNITY_BEGIN();

    RUN_TEST(test_validateCard_valid);
    RUN_TEST(test_validateCard_invalidLength);
    RUN_TEST(test_validateCard_containsLetter);
    RUN_TEST(test_validateCard_nonValid);

    RUN_TEST(test_getCash_invalidNumber);
    RUN_TEST(test_getCash_minNumber);
    RUN_TEST(test_getCash_notEnoughMoney);
    RUN_TEST(test_getCash_valid);

    RUN_TEST(test_putCash_valid);
    RUN_TEST(test_putCash_invalidNumber);
    RUN_TEST(test_putCash_minNumber);
    RUN_TEST(test_putCash_maxNumber);

    return UNITY_END();
}
