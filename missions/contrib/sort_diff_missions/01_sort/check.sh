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
  # The original files of the mission
  old_inventory=$(eval_gettext '$GSH_HOME/Garden/Flower_garden')/$(gettext "old_inventory")
  new_inventory=$(eval_gettext '$GSH_HOME/Garden/Flower_garden')/$(gettext "new_inventory")
  
  # The files sorted by the user
  sort_old=$(eval_gettext '$GSH_HOME/Garden/Flower_garden')/$(gettext "sort_old")
  sort_new=$(eval_gettext '$GSH_HOME/Garden/Flower_garden')/$(gettext "sort_new")

  # Check if the files "sort_old" "sort_new" and exists
  if [ ! -f "$sort_old" ] || [ ! -f "$sort_new" ]
    then
        echo "$(eval_gettext "The files don't exist...")"
        return 1
  fi

  # Check if the file "sort_old" is sorted
  if cmp -s "$sort_old" <(sort $old_inventory); then
    # Check if the file "sort_new" is sorted
    if cmp -s "$sort_new" <(sort $new_inventory); then
        # The files are the same
        return 0
    else
        # The files aren't the same
        echo "$(gettext "The file 'sort_new' is not sorted")"
        return 1
    fi
  else
      # The files aren't the same
      echo "$(gettext "The file 'sort_old' is not sorted")"
      return 1
  fi
}
_mission_check
