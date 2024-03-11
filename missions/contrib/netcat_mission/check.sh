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
  real_key=$(cat "$GSH_TMP/digits.txt")
  given_key=""
  
  while true
  do
    printf "%s " "$(gettext "What are the 4 digits inscribed on the base of the vial?")"
    read -r given_key
    case "$given_key" in
      "" | *[!0-9]*)
        :
        ;;
      *)
        break
        ;;
    esac
  done
  # don't check with '-ne' is it would accept non numerical answers!
  if [ "$real_key" != "$given_key" ]
  then
    echo "$(gettext "Those digits are not correct!")"
    return 1
  fi
  return 0
}
_mission_check
