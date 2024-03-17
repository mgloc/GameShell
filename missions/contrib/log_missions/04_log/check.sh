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
  # Get the answer
  answer_file="$GSH_TMP/04_log_answer.txt"
  answer_string="$(cat $answer_file)"

  # print the check question in the shell:
  printf "%s " "$(gettext "What is the answer?")"
  read -r input

  # Compare the user's input with the answer
  if [ "$answer_string" = "$input" ]; then
    return 0
  else
    echo "$(gettext "It's not the answer")"
    return 1
  fi
}
_mission_check
