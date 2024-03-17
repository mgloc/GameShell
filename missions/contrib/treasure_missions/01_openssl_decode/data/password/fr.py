import random

secret = "ThE_P455W0rD"

def choose_greatest():

    input("Choisit un nombre :")
    random_float = random.uniform(0, 10000)

    print( "Faux ! La bonne réponse est :"
        + str(random_float) )



choose_greatest()
