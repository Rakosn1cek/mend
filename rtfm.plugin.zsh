# ~/arch-projects/RTFM/rtfm.plugin.zsh
# Version: v0.1.1
# Author: Lukas Grumlik (Rakosn1cek)
# Description: The fzf-powered Pacman Fixer

# Find the directory where this script is located
# ${0:A:h} gets the Absolute path, then the Head (directory)
export RTFM_DIR="${0:A:h}"

# Add the functions subdirectory to the fpath
fpath+=("$RTFM_DIR/functions")

# Autoload the main function
autoload -Uz rtfm

# Provide a shorter alias
alias fix="rtfm"
