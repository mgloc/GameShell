_read_online_file_info(){
  # input ONLINE_FILE:(online file path) INFO_TYPE:(either 'api_url' or 'session_id')
  # return GSH_API_URL or GAME_SESSION_ID
  local ONLINE_FILE=$1
  local INFO_TYPE=$2

  case $INFO_TYPE in
    "api_url")
      # return the api url entered by the player
      GSH_API_URL=$(head -n1 "$ONLINE_FILE" | sed -r 's/^.*<api_url:([^>]*)>.*$/\1/')
      echo "$GSH_API_URL"
      ;;
    "session_id")
      # return the session id of the player
      GAME_SESSION_ID=$(head -n1 "$ONLINE_FILE" | sed -r 's/^.*<session_id:([^>]*)>.*$/\1/')
      echo "$GAME_SESSION_ID"
      ;;
    *)
      echo "Invalid info type. Please use 'name', 'api_url', or 'session_id'."
      return 1
      ;;
  esac

  return 0
}

_get_api_url(){
  # input ONLINE_FILE:(online file path)
  # return GSH_API_URL
  local ONLINE_FILE=$1
  local GSH_API_URL=http://$(_read_online_file_info "$ONLINE_FILE" "api_url")/
  echo "$GSH_API_URL"
}

####################### API REQUEST ############################

_api_request(){
  # input API_URL:(api url) API_ENDPOINT:(api endpoint) METHOD:(GET, POST, PUT, DELETE) DATA:(data to send)
  # return API_RESPONSE
  local API_URL=$1
  local API_ENDPOINT=$2
  local METHOD=$3
  local DATA=$4

  case $METHOD in
    "GET")
      API_RESPONSE=$(wget -qO- "$API_URL/$API_ENDPOINT")
      ;;
    "POST")
      API_RESPONSE=$(wget -qO- --post-data="$DATA" "$API_URL/$API_ENDPOINT")
      ;;
    "PUT")
      API_RESPONSE=$(wget -qO- --method=PUT --body-data="$DATA" "$API_URL/$API_ENDPOINT")
      ;;
    "DELETE")
      API_RESPONSE=$(wget -qO- --method=DELETE "$API_URL/$API_ENDPOINT")
      ;;
    *)
      echo "Invalid method. Please use 'GET', 'POST', 'PUT', or 'DELETE'."
      return 1
      ;;
  esac

  echo "$API_RESPONSE"
}


####################### TEST CONNECTIVITY ############################

_test_online() {
  # test if we're connected to internet
  if command -v wget >/dev/null
  then
    if wget -q --spider https://www.google.com
    then
      return 0
    fi
  fi
  return 1
}

_test_sessionexist(){
  local GAME_SESSION_ID=$1
  local GSH_API_URL=$2

  echo "Testing if session $GAME_SESSION_ID exists. .."
  SESSION_URL="http://$GSH_API_URL/gamesessions/$GAME_SESSION_ID"
  echo "Current API gamesession: $SESSION_URL"
  if wget -O/dev/null -q $SESSION_URL
  then
    return 0
  fi
  return 1
}

_test_api_connection(){
  local ONLINE_FILE=$1
  local PASSPORT=$2
  local API_URL=$(_read_online_file_info "$ONLINE_FILE" "api_url")
  local SESSION_ID=$(_read_online_file_info "$ONLINE_FILE" "session_id")
  local NAME=$(_read_passport_info "$PASSPORT" "name")

  echo "=================CONNECTION TESTING===================="
  if _test_online
  then
    echo "Connected to the internet"
    if _test_sessionexist $GAME_SESSION_ID $GSH_API_URL
    then
      echo "Session $SESSION_ID exists"
      return 0
    else
      echo "Session $SESSION_ID does not exist or the provided url is not working, please double check your session id and url or use the offline mode"
      return 1
    fi
  else
    echo "Not connected to the internet, please use the offline mode"
    return 1
  fi
  echo "======================================================="
}
