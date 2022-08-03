import cs50
import csv
from sys import argv
from sys import exit

if len(argv) != 2:
    print("Usage: python import.py (name of a CSV file)")
    exit(1)

db = cs50.SQL("sqlite:///students.db")

with open(argv[1], "r") as file:
    i = 1

    # Create DictReader
    reader = csv.DictReader(file)

    # Iterate over CSV file
    for row in reader:

        name = row["name"].split()
        house = row["house"]
        birth = row["birth"]

        # if character has 3 names
        if len(name) == 3:
            # Execute this SQL query:
            db.execute("INSERT INTO students (id, first, middle, last, house, birth) VALUES(?, ?, ?, ?, ?, ?)",
                       i, name[0], name[1], name[2], house, birth)

        # if character has 2 names
        elif len(name) == 2:
            # Execute this SQL query:
            db.execute("INSERT INTO students (id, first, middle, last, house, birth) VALUES(?, ?, ?, ?, ?, ?)",
                       i, name[0], None, name[1], house, birth)
        i += 1