#include <stdio.h>
#include <cs50.h>

int main(void)
{
    int height;
    do
    {
        height = get_int("Height: ");       //checking for right imput
    }
    while (height < 1 || height > 8);

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < height - (i + 1); j++)
        {
            printf(" ");                        //printing space
        }
        for (int x = 0; x < i + 1; x++)
        {
            printf("#");                        //first part of mario pyramid
        }
        for (int y = 0; y < 2; y++)
        {
            printf(" ");                        //printing gap
        }
        for (int x = 0; x < i + 1; x++)
        {
            printf("#");                        //second part of mario pyramid
        }
        printf("\n");                           //new line
    }
}
