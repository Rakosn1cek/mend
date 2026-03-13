# ------------------------------------------------------------------------------
# RTFM (Real-Time Fix Manager)
# Version:     v0.2.0
# Author:      Lukas Grumlik (Rakosn1cek)
# Description: Modular, fzf-powered recovery tool for Arch Linux.
# Repository:  https://github.com/Rakosn1cek/RTFM
# License:     MIT
# ------------------------------------------------------------------------------

# Find the directory where this script is located
# ${0:A:h} gets the Absolute path, then the Head (directory)
export RTFM_DIR="${0:A:h}"

# Add the functions subdirectory to the fpath
fpath+=("$RTFM_DIR/functions")

# Autoload the main function
autoload -Uz rtfm

# Provide a shorter alias
alias fix="rtfm"
