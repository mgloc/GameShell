#!/usr/bin/env sh

# This file is not required. It can be used to generate dynamic treasure
# messages.
# If you need this file, rename it to 'treasure-msg.sh'
#
# If the file exists, it is sourced when the mission is succesfully checked,
# when the treasure is sourced.
# If neither this file nor "treasure-msg.txt" exists, a "treasure-msg.sh" file
# with a single line is assumed:
cat "$(eval_gettext '$MISSION_DIR/treasure-msg/en.txt')"
