#!/bin/bash
# AI Package Installation Helper
# Opens kitty with bash (bypasses fish startup scripts) to install packages via paru
# Usage: ~/AI/scripts/install-pkg.sh <package-name>

if [ -z "$1" ]; then
    echo "Usage: $0 <package-name>"
    echo "Example: $0 glmark2"
    exit 1
fi

PACKAGE="$1"
echo "Opening kitty to install $PACKAGE..."
kitty bash -c "paru $PACKAGE" &
