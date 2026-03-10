# Library Version & Identity
TOOLS_LOADED=true
TOOLS_VERSION="1.0.2"


getInteger() {
    local PROMPT_TEXT="$1"
    local USER_INPUT=""
    local VALID=false

    while [ "$VALID" = false ]; do
        # Print the custom prompt to stderr so it doesn't get captured as data
        echo "$PROMPT_TEXT" >&2
        read USER_INPUT

        if [[ $USER_INPUT =~ ^[0-9]+$ ]]; then
            VALID=true
            echo "$USER_INPUT" # This is the "returned" value
        else
            echo "ERROR: '$USER_INPUT' is not a valid integer." >&2
        fi
    done
}
getNumber() {
    local PROMPT_TEXT="$1"
    local USER_INPUT=""
    local VALID=false

    while [ "$VALID" = false ]; do
        # Send prompt to stderr so it doesn't pollute the return value
        echo "$PROMPT_TEXT" >&2
        read USER_INPUT

        # Regex Breakdown:
        # ^[0-9]+(\.[0-9]+)?$
        # ^[0-9]+       : Starts with one or more digits
        # (\.[0-9]+)?   : Optionally followed by a dot and more digits
        # $             : End of string
        if [[ $USER_INPUT =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
            VALID=true
            echo "$USER_INPUT"
        else
            echo "ERROR: '$USER_INPUT' is not a valid number." >&2
        fi
    done
}
