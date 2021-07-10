def start(self):
    print("You are in a dark room.")
    print("There is a door to your right and left.")
    print("Which one do you take?")

    next = input("> ")
    if next == "left":
        bear_room(self)

    elif next == "right":
        cthulhu_room(self)
    else:
        dead("You stumble around the room until you starve.")
    
def bear_room(self):
    print("There is a bear here.")
    print("The bear has a bunch of honey.")
    print("The fat bear is in front of another door.")
    print("How are you going to move the bear?")
    bear_moved = False

    while True:
        next = input("> ")

        if next == "take honey":
            dead("The bear looks at you then slaps your face off.")
        elif next == "taunt bear" and not bear_moved:
            print("The bear has moved from the door.")
            print("You can go through it now.")
            bear_moved = True
        elif next == "taunt bear" and bear_moved:
            dead("The bear gets pissed off and chews your leg off.")
        elif next == "open door" and bear_moved:
            gold_room(self)
        else:
            print("I got no idea what that means.")

def dead(why):
    print(why, "Good job!")
    exit(0)

def gold_room(self):
    print("This room is full of gold.  How much do you take?")

    next = input("> ")
    if "0" in next or "1" in next:
        how_much = int(next)
    else:
        dead("      You greedy bastard!")

    if how_much < 50:
        print("      You're not greedy, you win!")
        exit(0)
    else:
        dead("      You greedy bastard!")

def cthulhu_room(self):
    print("Here you see the great evil Cthulhu.")
    print("He, it, whatever stares at you and you go insane.")
    print("Do you flee for your life or eat your head?")

    next = input("> ")

    if "flee" in next:
        start(self)
    elif "head" in next:
        dead("      You go insane.")
    else:
        cthulhu_room(self)

def main():
    start(None)

if __name__ == "__main__":
    main()