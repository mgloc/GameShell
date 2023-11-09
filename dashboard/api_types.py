class Progression:
    percentage: int

    def __init__(self, data):
        self.percentage = data["percentage"]


class Room:
    name: str
    progression: Progression
    best_player: str

    def __init__(self, data):
        self.name = data["name"]
        self.progression = Progression(data["progression"])
        self.best_player = data["best_player"]


class GlobalStats:
    rooms: list[Room]

    def __init__(self, data):
        self.rooms = []
        for room in data["rooms"]:
            self.rooms.append(Room(room))

    def get_room(self, room_name: str) -> dict:
        for room in self.rooms:
            if room["name"] == room_name:
                return room
        return None

    def get_best_room(self):
        """
        Returns the best room
        """
        best_score = 0
        best_room = None
        for room in self.rooms:
            if room.progression.percentage > best_score:
                best_score = room.progression.percentage
                best_room = room
        return best_room


class PersonalStats:
    firstname: str
    lastname: str
    username: str
    room: str
    progression: dict
    connectivity: bool

    def __init__(self, data):
        self.firstname = data["firstname"]
        self.lastname = data["lastname"]
        self.username = data["username"]
        self.room = data["room"]
        self.progression = data["progression"]
        self.connectivity = data["connectivity"]
