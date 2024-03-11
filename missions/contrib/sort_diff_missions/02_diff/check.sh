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
  # Get the answer_file
  answers_file=$GSH_TMP/answer.txt

  # Construct the answer string
  answers_string="$(head -n 1 $answers_file)"
  while IFS= read -r plant; do
      answers_string="$answers_string, $plant"
  done < <(tail -n 2 $answers_file)

  # print the check question in the shell:
  printf "%s " "$(gettext "Which species have been added to the garden?")"
  read -r input

  # Compare the user's input with the answer
  if [ "$answers_string" = "$input" ]; then
    return 0
  else
    echo "$(gettext "It's not the answer")"
    return 1
  fi
)
_mission_check
