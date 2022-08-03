#include <stdio.h>
#include <cs50.h>

int count_letters(string text);        // declaring functions
int count_words(string text);
int count_sentences(string text);

int main(void)
{
    string text = get_string("Text: ");        // asking for input
    int letters = count_letters(text);          // checking for letters, words, sentences
    int words = count_words(text);
    int sentences = count_sentences(text);
    float x = 100 / (float)words;
    float index = 0.0588 * (letters * x) - 0.296 * (sentences * x) - 15.8;      // Coleman-Liau index = output
    if (index < 1)                      // final output printf
    {
        printf("Before Grade 1\n");
    }
    else if (index > 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %0.f\n", index);
    }
}

int count_letters(string text)         // how many letters function
{
    int letters = 0;
    int i = 0;
    while (text[i] != '\0')
    {
        if ((text[i] >= 'a' && text[i] <= 'z') || (text[i] >= 'A' && text[i] <= 'z'))
        {
            letters++;
        }

        i++;
    }
    return letters;
}

int count_words(string text)           // how many words function
{
    int words = 0;
    int j = 0;
    while (text[j] != '\0')
    {
        if (text[j] == ' ')
        {
            words++;
        }

        j++;
    }
    return words + 1;
}

int count_sentences(string text)       // how many sentences function
{
    int sentences = 0;
    int y = 0;
    while (text[y] != '\0')
    {
        if (text[y] == '.' || text[y] == '?' || text[y] == '!')
        {
            sentences++;
        }

        y++;
    }
    return sentences;
}