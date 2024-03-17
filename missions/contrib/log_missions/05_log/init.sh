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

  # put the record in the Castle
  log=$(eval_gettext '$GSH_HOME/Castle/Main_building')/1306_$(gettext "record")
  python3 $MISSION_DIR/data/script/$(gettext "en") $log

  # put the template in the Castle
  template=$(eval_gettext '$GSH_HOME/Castle/Main_building')/$(gettext "template")
  cat $MISSION_DIR/data/template/$(gettext "en").txt > $template

  # get the answer
  grep -i $(gettext "Error") $log | awk -F':' '{print $1}' | sort | uniq -c | sort -rn | awk 'NR==1 {print $2}'> "$GSH_TMP/05_log_answer.txt"
}
_mission_init
