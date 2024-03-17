import random

secret = "ThE_P455W0rD"

def choose_greatest():

    input("Choose a number? ")
    random_float = random.uniform(0, 10000)

    print( "Wrong ! The right answer is "
        + str(random_float) )



choose_greatest()
