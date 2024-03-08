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

function put_gems() {
    gemstone="$1"  # Name of the gem
    N="$2"    # Number of gems to create

    # Loop to create gems
    for ((i = 1; i <= N; i++)); do
        gemstone_file="$GSH_TMP/$(gettext $gemstone)_$i"
        sign_file "$MISSION_DIR/ascii-art/$gemstone.txt" "$gemstone_file"
    done
}

_mission_init() {
  treasure_chest=$(eval_gettext '$GSH_HOME/Castle/Main_building/Throne_room/Safe')/$(gettext 'Treasure_chest')

  # 2. Create jewels
  put_gems "ruby" 22
  put_gems "sapphire" 26
  put_gems "money" 60
  put_gems "emerald" 32
  put_gems "diamond" 44
  put_gems "coal" 13

  # créer une archive du coffre
  tar -cvf $treasure_chest -C "$GSH_TMP" .
}
_mission_init
