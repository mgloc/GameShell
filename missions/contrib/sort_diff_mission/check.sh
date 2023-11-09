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

_mission_check() (
  difference="Daffodil"

  printf "%s " "$(gettext "What is the difference?")"
  read -r answer

  if [ "$difference" != "$answer" ]
  then
    echo "$(gettext "It's not the good answer")"
    return 1
  fi

  if [ "$difference" = "$answer" ]
  then
    return 0
  fi
)

_mission_check

