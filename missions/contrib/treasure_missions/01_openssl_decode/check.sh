#!/usr/bin/env sh

# This file is required. It is sourced when checking the goal of the mission
# has been achieved.
# It should end with a command returning 0 on success, and something else on
# failure.
# It should "unset" any local variable it has created, and any "global
# variable" that were only used for the mission. (The function _mission_check
# is automatically unset.)
#
# It typically looks like

_mission_check() {
  treasure_chest=$(eval_gettext '$GSH_HOME/Castle/Main_building/Throne_room/Safe')/$(gettext 'treasure_chest').txt

  # check if the file exist
  if [ ! -f "$treasure_chest" ]
    then
        echo "$(eval_gettext "The file treasure_chest.txt doesn't exist...")"
        return 1
  fi

  if cmp -s "$treasure_chest" "$MISSION_DIR/ascii-art/treasure-chest.txt"; then
    return 0
  else
  # The files aren't the same
      echo "$(gettext "You did not decrypt the file treasure_chest.enc")"
      return 1
  fi
}
_mission_check
