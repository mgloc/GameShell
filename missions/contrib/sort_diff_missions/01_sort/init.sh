#!/usr/bin/env sh

# This file is not required: it is sourced every time the mission is started.
# Since it is sourced every time the mission is restarted, it can generate
# random data to make each run slightly different.
#
# Since it is sourced, it may define environment variables if you really need
# them, but it should "unset" any local variable it has created.
#
# Note however that should the mission be initialized in a subshell, those
# environment variables will disappear! That typically happens a mission is
# checked using process redirection, as in
#   $ SOMETHING | gsh check
# To mitigate the problem, GameShell will display a message asking the player
# to run
#   $ gsh reset
# in that case.
#
# It typically looks like
_mission_init() {
  new_inventory=$(eval_gettext '$GSH_HOME/Garden/Flower_garden')/$(gettext "new_inventory")
  sort -R $MISSION_DIR/data/plants/$(gettext "en").txt | head -n 100 > $new_inventory

  sort -R $new_inventory > $GSH_TMP/random.txt
  random=$GSH_TMP/random.txt
  old_inventory=$(eval_gettext '$GSH_HOME/Garden/Flower_garden')/$(gettext "old_inventory")
  head -n 94 $random > $old_inventory
  tail -n 6 $random | sort > $GSH_TMP/answer.txt
}
_mission_init
