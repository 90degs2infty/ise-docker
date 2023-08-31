#!/bin/bash

echo "=== Entered the container ==="

if [[ $# -eq 0 ]]; then
    CMDS="$(find /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/ -maxdepth 1 -perm -111 -type f -printf '%f\n')"

    echo
    echo "No command specified. Available commands include:"
    echo
    echo "$(echo "$CMDS" | sort -fu | tr '\n' ' ')"
    echo
    echo "=== Leaving the container ==="
    echo

    exit 1
fi

# load all the Xilinx settings
# for a reason I have not looked into, settings64.sh does not pick up the
# install directory on its own when called from a script (as opposed to when
# called from .bashrc). Luckily, it supports specifying the install directory
# explicitly.
. /opt/Xilinx/14.7/ISE_DS/settings64.sh /opt/Xilinx/14.7/ISE_DS > /dev/null

echo
echo "Received command '$@'"
echo

"$@"

echo
echo "=== Leaving the container ==="
echo
