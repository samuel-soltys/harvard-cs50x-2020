from cs50 import get_string

while True:
    cardNum = get_string("Enter your credit card number: ")
    if int(cardNum) > 1:
        break

digits = [int(i) for i in cardNum]
summ = 0

for i in digits[::2]:
    digits.remove(i)
    i *= 2
    i = sum(int(digit) for digit in str(i))
    summ += i

finalSum = sum(digits) + summ

if len(cardNum) == 15 and (cardNum[:2] in ("34", "37")):
    print("AMEX")
elif len(cardNum) == 16 and (cardNum[:2] in ("51", "52", "53", "54", "55")):
    print("MASTERCARD")
elif (len(cardNum) == 16 or len(cardNum) == 13) and cardNum[:1] in ("4"):
    print("VISA")
else:
    print("INVALID")