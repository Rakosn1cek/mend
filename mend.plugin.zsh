# ------------------------------------------------------------------------------
# MEND - The Distro-Agnostic Linux Command Assistant
# Version: 0.8.4
# Author:  Rakosn1cek (https://github.com/Rakosn1cek/mend)
# License: MIT
# ------------------------------------------------------------------------------

# Find the directory where this script is located
MEND_DIR="${0:A:h}"

# Define the data directory path and EXPORT it
if [[ -d "$MEND_DIR/data" ]]; then
    export MEND_DATA_DIR="$MEND_DIR/data"
else
    export MEND_DATA_DIR="/usr/share/zsh/plugins/mend/data"
fi

# Export MEND_DIR so the main function can find its modules
export MEND_DIR="$MEND_DIR"

# Add the functions subdirectory to the fpath
fpath+=("$MEND_DIR/functions")

# Autoload the main function
autoload -Uz mend
