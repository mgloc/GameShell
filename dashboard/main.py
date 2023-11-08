from time import sleep, time
import math

from dashing import *

from api_types import Room, PersonalStats, GlobalStats


class Settings:
    # These might not correspond to the actual colors that you will see in your terminal
    colors: dict = {
        "red": 1,
        "green": 2,
        "yellow": 3,
        "blue": 4,
        "purple": 5,
        "white": 7,
        "grey": 8,
    }
    default_colors: dict = {
        "text": "white",
        "border": "purple",
    }

    def get_element_color(self, element_name: str) -> int:
        return self.colors[self.default_colors[element_name]]

    def get_bool_color(self, boolean: bool) -> int:
        if boolean:
            return self.colors["green"]
        return self.colors["red"]

    def get_room_color(self, room_index: int) -> int:
        return room_index % len(self.colors) + 1


def personal_panel(stats: PersonalStats, settings: Settings):
    return VSplit(
        VSplit(
            Text(
                f"Logged as: {stats.username}\nName: {stats.firstname} {stats.lastname}\nRoom: {stats.room}",
                color=settings.get_element_color("text"),
            ),
            Text(
                f"Connectivity: {'online' if stats.connectivity else 'offline'}",
                color=settings.get_bool_color(stats.connectivity),
            ),
            title="Informations",
            border_color=settings.get_element_color("border"),
        ),
        HGauge(
            val=stats.progression["percentage"],
            title="Personal progression",
            label=f"{stats.progression['percentage']}%",
            border_color=settings.get_element_color("border"),
        ),
        title="Personal stats",
    )


def global_panel(global_stats: GlobalStats, settings: Settings):
    best_room = global_stats.get_best_room()
    best_room_index = global_stats.rooms.index(best_room)
    average_progression = math.floor(
        sum([room.progression.percentage for room in global_stats.rooms]) / len(global_stats.rooms)
    )
    return VSplit(
        VSplit(
            Text(
                f"Best player: {best_room.best_player}\nBest room: {best_room.name}",
                color=settings.get_room_color(best_room_index),
            ),
            Text(
                f"Rooms: {len(global_stats.rooms)}\nAverage progression: {average_progression}%",
                color=settings.get_element_color("text"),
            ),
            border_color=settings.get_element_color("border"),
        ),
        VSplit(
            HSplit(
                *[
                    Text(f"{room.name} {room.progression.percentage}%", color=settings.get_room_color(i))
                    for i, room in enumerate(global_stats.rooms)
                ],
            ),
            HSplit(
                *[
                    VGauge(room.progression.percentage, color=settings.get_room_color(i))
                    for i, room in enumerate(global_stats.rooms)
                ],
            ),
            border_color=settings.get_element_color("border"),
        ),
        title="Global stats",
    )


if __name__ == "__main__":
    self_data = {
        "firstname": "John",
        "lastname": "Doe",
        "username": "JohnTheDoe",
        "room": "117-A",
        "progression": {"percentage": 30},
        "connectivity": True,
    }
    global_data = {
        "rooms": [
            {
                "name": "117-A",
                "progression": {"percentage": 30},
                "best_player": "JohnTheDoe",
            },
            {
                "name": "117-B",
                "progression": {"percentage": 20},
                "best_player": "B",
            },
            {
                "name": "117-C",
                "progression": {"percentage": 70},
                "best_player": "I'm the best in 117-C hehe",
            },
            {
                "name": "117-D",
                "progression": {"percentage": 60},
                "best_player": "D",
            },
            {
                "name": "117-E",
                "progression": {"percentage": 70},
                "best_player": "E",
            },
            {
                "name": "117-F",
                "progression": {"percentage": 65},
                "best_player": "F",
            },
        ]
    }

    custom_personal_stats = PersonalStats(self_data)
    custom_settings = Settings()
    custom_global_stats = GlobalStats(global_data)

    my_personal_panel = personal_panel(custom_personal_stats, custom_settings)
    my_global_panel = global_panel(custom_global_stats, custom_settings) if self_data["connectivity"] else None

    if my_global_panel:
        ui = HSplit(
            my_personal_panel,
            my_global_panel,
        )
    else:
        ui = HSplit(
            personal_panel(custom_personal_stats, custom_settings),
        )

    ui.display()
