#include <stdio.h>
#include <cs50.h>
#include <ctype.h>

int main(int argc, string argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./substitution KEY\n");      // if user type only ./substitution
        return 1;
    }

    int length = 0;
    int i = 0;
    string key = argv[1];

    while (key[i] != '\0')
    {
        if (!((key[i] >= 'a' && key[i] <= 'z') || (key[i] >= 'A' && key[i] <= 'Z')))
        {
            printf("Key must only contain alphabetic characters.\n");       // if user type non alphabetical char
            return 1;
        }
        i++;
        length++;
    }

    if (length != 26)
    {
        printf("Key must contain 26 characters.\n");                        // if user dont type 26 characters
        return 1;
    }

    for (int j = 0; j < 26; j++)
    {
        for (int y = j + 1; y < 26; y++)
        {
            if (key[j] == key[y] || key[j] + 32 == key[y] || key[j] == key[y] + 32)
            {
                printf("Key must not contain repeated characters.\n");                  // if user type one letter more times
                return 1;
            }
        }
    }

    // VALID KEY !
    string plaintext = get_string("plaintext: ");                       // checking for input (plaintext)
    i = 0;
    printf("ciphertext: ");
    while (plaintext[i] != '\0')                                     // ENCIPHER
    {
        if (plaintext[i] >= 'A' && plaintext[i] <= 'Z')
        {
            printf("%c", toupper(key [plaintext[i] - 65]));
        }
        else if (plaintext[i] >= 'a' && plaintext[i] <= 'z')
        {
            printf("%c", tolower(key [plaintext[i] - 97]));
        }
        else
        {
            printf("%c", plaintext[i]);
        }
        i++;
    }
    printf("\n");

}