#include<stdio.h>
#include<cs50.h>

int main(void)
{
    long cardNum;
    int digit;
    int digitLength = 0;                    //defining integers
    int cardCheck = 0;
    int cardCheck2 = 0;

    do
    {
        cardNum = get_long("Enter your credit card number: ");      //input
    }
    while (cardNum < 1);            //must be positive number

    long cardNumCopy = cardNum;

    do
    {
        digit = cardNumCopy % 10;
        cardNumCopy = cardNumCopy / 10;         //Luhn’s Algorithm
        digitLength++;
        if (digitLength % 2 == 0)
        {
            digit *= 2;
            int digit_old = digit % 10;
            if (digit_old != digit)
            {
                cardCheck++;
            }
            digit = digit % 10;
            cardCheck = cardCheck + digit;
        }
        else
        {
            cardCheck2 = cardCheck2 + digit;    //adds remaining num (that werent multiplied by 2)
        }
    }
    while (cardNumCopy > 0);

    for (int i = 0; i < digitLength - 2; i++)
    {
        cardNum /= 10;                          //getting the first 2 digits
    }

    cardCheck = cardCheck + cardCheck2;  //final sum of cardCheck

    if (cardCheck % 10 == 0)
    {
        if (digitLength == 15 && (cardNum == 34 || cardNum == 37))   //checking validty of card and company of card
        {
            printf("AMEX\n");
        }
        else if ((cardNum == 51 || cardNum == 52 || cardNum == 53 || cardNum == 54 || cardNum == 55) && digitLength == 16)
        {
            printf("MASTERCARD\n");
        }
        else if (cardNum / 10 == 4 && (digitLength == 16 || digitLength == 13))
        {
            printf("VISA\n");
        }
        else
        {
            printf("INVALID\n");
        }
    }
    else
    {
        printf("INVALID\n");
    }
    /*

    American Express uses 15-digit numbers
    MasterCard uses 16-digit numbers
    Visa uses 13- and 16-digit numbers

    American Express numbers start with 34 or 37
    MasterCard numbers start with 51, 52, 53, 54, or 55
    Visa numbers start with 4
    */
}