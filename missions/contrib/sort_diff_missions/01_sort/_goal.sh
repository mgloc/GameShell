#!/usr/bin/env sh

# This file is not required. It can be used to generate dynamic goal messages.
# If you need that, rename the file to 'goal.sh'.
#
# If the file exists, it is sourced by the command
#  $ gsh goal
# If neither this file nor "goal.txt" exists, the command
#  $ gsh goal
# is equivalent to having the following line in goal.sh
cat "$(eval_gettext '$MISSION_DIR/goal/en.txt')"
