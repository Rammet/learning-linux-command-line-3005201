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


echo "--- STARFLEET NAVIGATION COMPUTER ---"
echo "Initializing Subspace Calculation..."
echo "------------------------------------"

# 1. String Input (No special validation needed for names)
echo "Enter Destination Star System:"
read DESTINATION

# 2. Numeric Inputs using your getNumber function
DIST=$(getNumber "Enter Distance in Light Years:")
AGE=$(getNumber "Enter Officer current age:")
VELOCITY=$(getNumber "Enter Velocity (percentage of c, e.g. 0.5):")

# 3. Calculate Travel Time (Time = Distance / Velocity)
# We use bc -l for floating point math
TRAVEL_TIME=$(echo "scale=4; $DIST / $VELOCITY" | bc -l)

# 4. Calculate Arrival Age
RAW_ARRIVAL_AGE=$(echo "scale=4; $AGE + $TRAVEL_TIME" | bc -l)
FINAL_AGE=$(printf "%.2f" "$RAW_ARRIVAL_AGE")

# 5. Calculate Arrival Date
# The 'date' command can add years using the '-d' flag.
# We convert TRAVEL_TIME to an integer for the date command to avoid syntax errors.
YEARS_INT=$(printf "%.0f" "$TRAVEL_TIME")

# 6. Convert Years to Days (365.25 to account for leap years)
# We use bc to keep the precision
DAYS_TOTAL=$(echo "$TRAVEL_TIME * 365.25" | bc -l)

# 7. Round that to a whole number for the date command
DAYS_INT=$(printf "%.0f" "$DAYS_TOTAL")

# 8. Add the DAYS to the current date
ARRIVAL_DATE=$(date -d "+$DAYS_INT days" +"%B %d, %Y")

echo "------------------------------------"
echo "NAVIGATION REPORT: $DESTINATION"
echo "------------------------------------"
echo "Departure Date: $(date +"%B %d, %Y")"
echo "Travel Time:    $TRAVEL_TIME years (~$DAYS_INT days)"
echo "Arrival Date:   $ARRIVAL_DATE"
echo "Officer Age:    $FINAL_AGE years"
echo "------------------------------------"
