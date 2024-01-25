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
  goodAnswer=$MISSION_DIR/data/answer_file/$(gettext "en").txt
  answeredFile=$(eval_gettext '$GSH_HOME/Castle/Main_building/Throne_room')/$(gettext "princess_letter")
  if cmp -s "$answeredFile" "$goodAnswer"; then
    # The files are the same
    return 0
  else
    # The files aren't the same
    echo "$(gettext "I still can't understand the file")"
    return 1
  fi
}
_mission_check
