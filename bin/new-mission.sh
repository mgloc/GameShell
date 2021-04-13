#!/bin/bash

export GASH_BASE="$(dirname "$0")/.."

display_help() {
cat <<EOH
$(basename $0) [NB] NAME: create template for a new mission
If NB is not given, use the first available mission number.

options:
  -h          this message

  -N          no gettext
  -G          with gettext

EOH
}


first_unused_number() {
    find "$GASH_BASE/missions/" -type d -name "*_*"     | \
    sed -n '/.*\/\([0-9]*\)_[^/]*/p'                    | \
    sed 's|.*/\([0-9]*\)_[^/]*|\1|'                     | \
    sort -n                                             | \
    awk 'BEGIN {N=1} /[0-9]+/ {if ($1 != N) {print N; exit 0;} N++}'
}


new_static_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/static.sh
#!/bin/bash

#
# This file is not required: it is sourced once when initialising a GameShell
# game. It typically creates the parts of the mission that will be available
# during the whole game, like the directory structure.
#
# Since it is sourced, it may define environment variables if you really need
# them, but it should "unset" any local variable it has created.
#
EOF
}

new_goal_txt_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/goal.txt
This file or one of its more complex variants (refer to the documentation) is
required.

It is displayed in its entirety by the command
  $ gash show
It should describe the goal of the mission.

Note: if the __first_ line of this file is of the form
# variables: $VAR1 $VAR2
those variables are substituted in the file.
EOF
}

new_goal_gettext_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/_goal.sh
#!/bin/bash

# This file is not required. It can be used to generate dynamic goal messages.
# If the file exists, it is sourced by the command
#  $ gash show
# If neither this file nor "goal.txt" exists, the command
#  $ gash show
# is equivalent to having the following line in goal.sh
cat "$(eval_gettext '$MISSION_DIR/goal/en.txt')"
EOF

    mkdir "$MISSION_DIR/goal/"
    cat <<'EOF' > "$MISSION_DIR"/goal/en.txt
This file or one of its more complex variants (refer to the documentation) is
required.

It is displayed in its entirety by the command
  $ gash show
It should describe the goal of the mission.

Note: if the __first_ line of this file is of the form
# variables: $VAR1 $VAR2
those variables are substituted in the file.
EOF
}

new_init_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/init.txt
#!/bin/bash

# This file is not required: it is sourced every time the mission is started.
# It typically creates the parts that are necessary for completing.
# Since it is sourced every time the mission is restarted, it should can
# generate random data to make each run slightly different.
#
# Since it is sourced, it may define environment variables if you really need
# them, but it should "unset" any local variable it has created.
#
# Note however that should the mission be initialized in a subshell, those
# environment variables will disappear! (That typically happens a mission is
# checked using process redirection, as in
#   $ SOMETHING | gash check
# To mitigate the problem, GameShell will display a message asking the player
# to run
#   $ gash reset
# in that case.
EOF
}

new_check_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/check.sh
#!/bin/bash

# This file is required. It is sourced when checking the goal of the mission
# has been achieved.
# It should end with a command returning 0 on success, and something else on
# failure.
# It should "unset" any local variable it has created, and any "global
# variable" that were only used for the mission
#

 ...
 ...

if ...
then
    unset ...
    true
else
   unset ...
   false
fi
EOF
}

new_auto_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/_auto.sh
#!/bin/bash

# This file is not required. When it exists, it is used to automatically
# validate the mission.
# It is allowed to "cheat" by using any hidden data.
EOF
}

new_clean_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/_clean.sh
#!/bin/bash

# This file is not required. When it exists, it is used to clean the mission,
# for example on completion, or when restarting it.
EOF
}

new_treasure_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/_treasure.sh
#!/bin/bash

# This file is not required. When it exists, it is sourced on successfull
# completion and is added to the global configuration.
# It is typically used to "reward" the player with new features like aliases
# and the like.
#
# Note that should the mission be completed in a subshell, aliases or
# environment variables will disappear.
# That typically happens a mission is checked using process redirection, as in
#   $ SOMETHING | gash check
# To mitigate the problem, GameShell will display a message asking the player
# to run
#   $ gash reset
# in that case.
EOF
}

new_treasure-msg_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/_treasure-msg.txt
This file is not required. When it exists, it is displayed when sourcing the
"treasure.sh" file. (If no "treasure.sh" file exists, this file will be
ignored.)
EOF
}

new_gettext_treasure-msg_file() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/_treasure-msg.sh
#!/bin/bash

# This file is not required. It can be used to generate dynamic treasure
# messages.
# If the file exists, it is sourced when the mission is succesfully checked,
# when the treasure is sourced.
# If neither this file nor "treasure-msg.txt" exists, a "treasure-msg.sh" file
# with a single line is assumed:
cat "$(eval_gettext '$MISSION_DIR/treasure-msg/en.txt')"
EOF

    mkdir "$MISSION_DIR/treasure-msg/"
    cat <<'EOF' > "$MISSION_DIR"/treasure-msg/en.txt
This file is not required. When it exists, it is displayed when sourcing the
"treasure.sh" file. (If no "treasure.sh" file exists, this file will be
ignored.)
EOF
}

new_po_files() {
    MISSION_DIR="$1"

    mkdir "$MISSION_DIR/i18n/"
    cat <<'EOF' > "$MISSION_DIR"/i18n/template
#, fuzzy
msgid ""
msgstr ""
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: 8bit\n"

# path for the text file containing the goal
msgid "$MISSION_DIR/goal/en.txt"
msgstr ""

# path for the text file containing the treasure message
msgid "$MISSION_DIR/treasure-msg/en.txt"
msgstr ""
EOF
}

new_makefile() {
    MISSION_DIR="$1"

    cat <<'EOF' > "$MISSION_DIR"/Makefile

##
# TODO: generate new po file from template with msgen

LANG=$(wildcard i18n/*.po)

all: $(LANG)

$(LANG):%.po: i18n/template
	msgmerge --update --no-wrap $@ i18n/template

i18n/template: *.sh
	xgettext --from-code=UTF-8 --omit-header --no-wrap --join-existing --output i18n/template *.sh

new: i18n/template
	@read -p "language code: " lang; \
        [ -e "./i18n/$$lang.po" ] && echo "file i18n/$$lang.po already exists" && exit; \
        echo "file i18n/$$lang.po created"; \
		msgen --no-wrap --output i18n/$$lang.po i18n/template

clean:
	rm i18n/*~

cleaner: clean
	find . -maxdepth 1 -type f -name "_*" -print0 | xargs -0 --open-tty rm -i

.PHONY: clean cleaner translation
EOF
}

new_mission_without_gettext() {
    NB=$1
    NAME=$2
    MISSION_DIR="$GASH_BASE/missions/contrib/${NB}_${NAME}"

    if [ -e "$MISSION_DIR" ]
    then
        echo "Path $MISSION_DIR already exists!" >&2
        echo "aborting" >&2
        exit 1
    fi

    echo "Creating mission ${NB}_${NAME} in directory $GASH_BASE/missions/contrib/"
    mkdir "$MISSION_DIR"

    new_static_file "$MISSION_DIR"
    new_goal_txt_file "$MISSION_DIR"
    new_init_file "$MISSION_DIR"
    new_check_file "$MISSION_DIR"
    new_auto_file "$MISSION_DIR"
    new_clean_file "$MISSION_DIR"
    new_treasure_file "$MISSION_DIR"
    new_treasure-msg_file "$MISSION_DIR"
}


new_mission_with_gettext() {
    NB=$1
    NAME=$2
    MISSION_DIR="$GASH_BASE/missions/contrib/${NB}_${NAME}"

    if [ -e "$MISSION_DIR" ]
    then
        echo "Path $MISSION_DIR already exists!" >&2
        echo "aborting" >&2
        exit 1
    fi

    echo "Creating mission ${NB}_${NAME} in directory $GASH_BASE/missions/contrib/"
    mkdir "$MISSION_DIR"

    new_static_file "$MISSION_DIR"
    new_goal_gettext_file "$MISSION_DIR"
    new_init_file "$MISSION_DIR"
    new_check_file "$MISSION_DIR"
    new_auto_file "$MISSION_DIR"
    new_clean_file "$MISSION_DIR"
    new_treasure_file "$MISSION_DIR"
    new_gettext_treasure-msg_file "$MISSION_DIR"
    new_po_files "$MISSION_DIR"
    new_makefile "$MISSION_DIR"
}


GETTEXT=""


while getopts ":hNG" opt
do
  case $opt in
    h)
      display_help
      exit 0;
      ;;
    N)
      GETTEXT=0
      ;;
    G)
      GETTEXT=1
      ;;
    *)
      echo "invalid option: '-$OPTARG'" >&2
      exit 1
esac
done

shift $((OPTIND - 1))

if [ "$#" -eq 1 ]
then
    NB=$(first_unused_number)
    NAME=$1
elif [ "$#" -eq 2 ]
then
    NB=$1
    NAME=$2
else
    echo "wrong number of arguments" >&2
    exit 1
fi


_m=$(find "$GASH_BASE/missions/" -type d -name "${NB}_*" -print -quit)
if [ -n "$_m" ]
then
    echo "There is at least another mission with number $NB: $_m." >&2
fi


if [ -z "$GETTEXT" ]
then
    echo "You must choose either '-N' (no gettext support) or '-G' (gettext support)." >&2
    exit 1
elif [ "$GETTEXT" = 0 ]
then
    new_mission_without_gettext "$NB" "$NAME"
elif [ "$GETTEXT" = 1 ]
then
    new_mission_with_gettext "$NB" "$NAME"
else
    echo "Oops... Unknown GETTEXT value." >&2
    exit 1
fi

