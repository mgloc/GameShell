#!/usr/bin/env sh

# This file is not required: it is sourced every time the mission is started.
# Since it is sourced every time the mission is restarted, it can generate
# random data to make each run slightly different.
#
# Since it is sourced, it may define environment variables if you really need
# them, but it should "unset" any local variable it has created.
#
# Note however that should the mission be initialized in a subshell, those
# environment variables will disappear! That typically happens a mission is
# checked using process redirection, as in
#   $ SOMETHING | gsh check
# To mitigate the problem, GameShell will display a message asking the player
# to run
#   $ gsh reset
# in that case.
#
# It typically looks like

_mission_init() {
  treasure_chest=$(eval_gettext '$GSH_HOME/Castle/Main_building/Throne_room/Safe')/$(gettext 'treasure_chest')

  # Lecture du mot de passe depuis le fichier password.txt
  password=$(cat "$MISSION_DIR/data/password.txt")

  # Chiffrer l'archive avec OpenSSL en utilisant le mot de passe
  openssl enc -aes-256-cbc -in "$MISSION_DIR/ascii-art/treasure-chest.txt" -out "$treasure_chest.enc" -pass pass:"$password"
}

_mission_init
