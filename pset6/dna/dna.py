from csv import reader
from sys import argv
from sys import exit

# checking command line arguments
if len(argv) != 3:
    print("Usage: python dna.py (CSV file with STR counts) (text file with DNA sequence)")
    exit(1)

# loading csv database and converting to list
csv_file = open(argv[1], "r")
csv_reader = reader(csv_file)
csv_list = list(csv_reader)

# loading .txt file and converting to string
sequence_file = open(argv[2], "r")
sequence = sequence_file.read()

# creating list for highest sequence in a row for every STR (AGAT, TATC, ...)
total_highest = []

# searching for STR sequences
for i in range(1, len(csv_list[0])):        # taking AGAT or TATC
    j = 0
    counter = 0
    highest = 0
    while j < len(sequence):        # looping over sequence of DNA one by one
        if csv_list[0][i] in sequence[j:j + len(csv_list[0][i])]:       # if STR founded (AGAT, TATC, ...)
            counter += 1                            # update counter
            j += len(csv_list[0][i])                # skip the loop by the lenght of the STR
        else:                       # STR not founded
            if counter > highest:       # write down the counter if it was higher then the previous ones
                highest = counter
            counter = 0                 # reset counter
            j += 1                      # countinue looping one by one char
    total_highest.append(f"{highest}")  # add highest to total highest list as a string

counter = 0
match = 0

# comparing total highest seqence in a row of STR (AGAT, TATC, ...) to all of people from database
for i in range(1, len(csv_list)):
    for j in range(1, len(csv_list[i])):
        if csv_list[i][j] == total_highest[j - 1]:
            counter += 1                                # adding counter
    if counter == len(csv_list[i]) - 1:                 # if counter was added for all of the elements in database for one person
        match = i                                       # then write down the index of the match
    counter = 0                                         # and reset counter

if match == 0:                      # if there was no match
    print("No match")
else:
    print(csv_list[match][0])       # if there was a match print out a name of the matched person

csv_file.close()                    # closing files
sequence_file.close()
