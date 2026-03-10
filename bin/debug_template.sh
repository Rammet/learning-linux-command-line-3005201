#!/bin/bash


# ----------------------------------------------------------------------
# Debug script template
#
# To run in debug mode, see example:
#
# DEBUG=1 ./debug_template.sh worf gagh
# ----------------------------------------------------------------------


# --- Debug helpers ---
DEBUG=${DEBUG:-0}


log() {
   [ "$DEBUG" -eq 1 ] && echo "DEBUG: $*"
}


pause() {
   [ "$DEBUG" -eq 1 ] && read -p "DEBUG pause — press Enter to continue..." _
}


# --- Place code below  - example follows ---
USER_NAME=$1
TREET=$2


log "args: 1=<$1> 2=<$2> (#=$#)"
pause




log "USER_NAME=${USER_NAME}"
log "TREAT=${TREAT}"
pause


echo "$USER_NAME really enjoys $TREAT!"
