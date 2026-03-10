#!/bin/bash
USER_NAME=$1
TREET=$2

# --- 1. Argument Validation ---
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <USER_NAME> <TREAT>"
    echo "Example: $0 worf gagh"
    exit 1
fi

echo "$USER_NAME really enjoys $TREAT!"

