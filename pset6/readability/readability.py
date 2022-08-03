from cs50 import get_string

# Asking for text input
text = get_string("Text: ")


def main():
    letters = count_letters(text)   # counts letters
    words = text.count(' ') + 1     # counts words
    sentences = text.count('.') + text.count('!') + text.count('?')     # counts sentences
    calculate_grade(letters, words, sentences)      # calculate index and prints out grade


def count_letters(str):
    counter = 0
    for i in text:
        if 'a' <= i <= 'z' or 'A' <= i <= 'Z':
            counter += 1
    return counter


def calculate_grade(letters, words, sentences):
    average = 100 / float(words)
    index = 0.0588 * (letters * average) - 0.296 * (sentences * average) - 15.8
    if (index < 1):
        print("Before Grade 1")
    elif (index > 16):
        print("Grade 16+")
    else:
        print(f"Grade {round(index)}")
    return 0


main()