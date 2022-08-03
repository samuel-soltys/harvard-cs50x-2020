import cs50
from sys import argv
from sys import exit

if len(argv) != 2:
    print("Usage: python import.py (name of a house)")
    exit(1)

db = cs50.SQL("sqlite:///students.db")

students = db.execute("SELECT first, middle, last, birth FROM students WHERE house = ? ORDER BY last, first", argv[1])

# going throught list of dicts of students
for i in range(len(students)):
    # if student has only 2 names:
    if students[i]["middle"] == None:
        print(students[i]["first"], students[i]["last"] + ", born", students[i]["birth"])
    # if student has 3 names:
    else:
        print(students[i]["first"], students[i]["middle"], students[i]["last"] + ", born", students[i]["birth"])
