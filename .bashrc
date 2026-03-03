 ~/.bashrc

# Enable colorful ls and grep output
export CLICOLOR=1
export LS_COLORS='di=34:fi=0:ln=35:pi=33:so=32:bd=46:cd=43:ex=31'

# Helpful aliases
alias ll='ls -alF'
alias la='ls -A'
alias ..='cd ..'
alias cls='clear'

# Enable color for grep
alias grep='grep --color=auto'

# Make prompt user-friendly
PS1='\[\e[32m\]\u@\h\[\e[m\]:\[\e[34m\]\w\[\e[m\]\$ '

# Only add to PATH if it isn't already there
if [[ ":$PATH:" != *":$(pwd)/bin:"* ]]; then
    export PATH="$PATH:$(pwd)/bin"
fi
./bin/repo.sh
cd ~/repo

# Save current directory to a history file, keeping the last 5 unique paths
save_dir_history() {
    local hist_file="$HOME/.dir_history"
    touch "$hist_file"
    # Add current dir, remove duplicates, keep last 5
    (echo "$PWD"; cat "$hist_file") | awk '!x[$0]++' | head -n 5 > "$hist_file.tmp" && mv "$hist_file.tmp" "$hist_file"
}
trap save_dir_history EXIT

# Directory Resume Menu
if [ -f ~/.dir_history ] && [ -s ~/.dir_history ]; then
    echo "--- Previous Sessions ---"
    
    # Map history into an array
    mapfile -t dirs < ~/.dir_history
    
    # Add an option to stay in current workspace
    options=("${dirs[@]}" "Stay in current workspace")
    
    echo "Choose a directory to resume (or wait 10s for default):"
    
    # Use a timeout for the selection
    TMOUT=10
    select opt in "${options[@]}"; do
        if [ -n "$opt" ] && [ "$opt" != "Stay in current workspace" ]; then
            cd "$opt"
            break
        else
            echo "Starting in workspace."
            break
        fi
    done
    unset TMOUT # Reset timeout so it doesn't affect your shell session
fi

# Function to display the directory menu
dmenu() {
    if [ -f ~/.dir_history ] && [ -s ~/.dir_history ]; then
        # Map history into an array
        mapfile -t dirs < ~/.dir_history
        
        # Add an option to stay/cancel
        options=("${dirs[@]}" "Stay in current workspace")
        
        echo "--- Directory History ---"
        # No timeout here so you can take your time choosing
        PS3="Choose a directory (or 'q' to quit): "
        select opt in "${options[@]}"; do
            if [ -n "$opt" ] && [ "$opt" != "Stay in current workspace" ]; then
                cd "$opt"
                break
            else
                break
            fi
        done
    else
        echo "No directory history found yet!"
    fi
}
