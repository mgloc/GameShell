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

# Receives ruby number as first argument.
_mission_check() (
    ruby_name="$(gettext "ruby")_$1"
    GSH_CHEST="$(eval_gettext '$GSH_HOME/Forest/Hut/Chest')"

    n=$(find "$GSH_CHEST" -maxdepth 1 -name "$ruby_name" | wc -l)
    if [ "$n" -gt 1 ]
    then
        echo "$(eval_gettext "There are several '\$ruby_name' in your chest!")"
        return 1
    elif [ "$n" -eq 0 ]
    then
        echo "$(eval_gettext "There is no '\$ruby_name' in your chest!")"
        return 1
    fi

    # check the content of the ruby
    if ! cmp -s "$GSH_CHEST/$ruby_name" "$GSH_TMP/$ruby_name"
    then
        echo "$(eval_gettext "The ruby '\$ruby_name' has been tampered with...")"
        return 1
    fi

    return 0
)

# Check if each ruby (22 ruby) is in the chest
for ((i = 1; i <= 22; i++)); do
    _mission_check "$i"
done
