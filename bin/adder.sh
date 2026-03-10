#!/bin/bash

# Attempt to source the library
source ./tools.sh 2>/dev/null

# Troubleshooting: Check if the 'handshake' variable exists
if [ "$TOOLS_LOADED" != "true" ]; then
    echo "CRITICAL ERROR: Navigation Library (tools.sh) not found!"
    echo "Ensure tools.sh is in the same directory as this script."
    exit 1
fi

echo "Systems Check: Library v$TOOLS_VERSION Loaded."


echo "Welcome to the adder"
# Calling the function and capturing the output into a variable
NUM1=$(getNumber "Please enter the first number:")
NUM2=$(getNumber "Enter a second number.")

SUM=$(echo "scale=4; $NUM1 + $NUM2" | bc -l)

echo "-----------------------------------"
echo "$NUM1 + $NUM2 = $SUM"
