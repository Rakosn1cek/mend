# ------------------------------------------------------------------------------
# MEND - The Distro-Agnostic Linux Command Assistant
# Version: 0.7.0
# Author:  Rakosn1cek (https://github.com/Rakosn1cek/mend)
# License: MIT
# ------------------------------------------------------------------------------
# This code is the original work of Lukas Grumlik - (Rakosn1cek). Attribution is required.
# ------------------------------------------------------------------------------

# Find the directory where this script is located
MEND_DIR="${0:A:h}"

# Add the functions subdirectory to the fpath
fpath+=("$MEND_DIR/functions")

# Autoload the main function
autoload -Uz mend

# Shorter alias for convenience
alias fix="mend"

# Compatibility bridge for legacy 'rtfm' users
function rtfm() {
    print -P "%F{yellow}Mend:%f 'rtfm' has been renamed to 'mend'. Please use %F{cyan}mend%f or %F{cyan}fix%f."
    mend "$@"
}
