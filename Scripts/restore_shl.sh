#!/usr/bin/env bash
#|---/ /+---------------------------+---/ /|#
#|--/ /-| Script to configure shell |--/ /-|#
#|-/ /--| Prasanth Rangan           |-/ /--|#
#|/ /---+---------------------------+/ /---|#

scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/global_fn.sh"
if [ $? -ne 0 ]; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

if chk_list "myShell" "${shlList[@]}"; then
    echo -e "\033[0;32m[SHELL]\033[0m detected // ${myShell}"
else
    echo "Error: user shell not found"
    exit 1
fi

# set shell
if [[ "$(grep "/${USER}:" /etc/passwd | awk -F '/' '{print $NF}')" != "${myShell}" ]]; then
    echo -e "\033[0;32m[SHELL]\033[0m changing shell to ${myShell}..."
    chsh -s "$(which "${myShell}")"
else
    echo -e "\033[0;33m[SKIP]\033[0m ${myShell} is already set as shell..."
fi
