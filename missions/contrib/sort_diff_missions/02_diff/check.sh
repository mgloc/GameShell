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
  answers_file=$GSH_TMP/answer.txt
  answers_list="$(head -n 1 $answers_file)"
  while IFS= read -r plant; do
      answers_list="$answers_list, $plant"
  done < <(tail -n 2 $answers_file)
  echo "$answers_list"

  printf "%s " "$(gettext "Which species have been added to the garden?")"
  read -r input

  if [ "$answers_list" = "$input" ]; then
    return 0
  else
    echo "$(gettext "It's not the good answer")"
    return 1
  fi
)
_mission_check
