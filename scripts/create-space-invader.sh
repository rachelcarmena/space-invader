#!/bin/bash

# Header created by http://www.network-science.de/ascii/
function print_banner() {
    echo "...................................................................."
    echo "                                _                     _             "
    echo "                               (_)                   | |            "
    echo "  ___ ____   ____  ____ ____    _ ____ _   _ ____  _ | | ____  ____ "
    echo " /___)  _ \ / _  |/ ___) _  )  | |  _ \ | | / _  |/ || |/ _  )/ ___)"
    echo "|___ | | | ( ( | ( (__( (/ /   | | | | \ V ( ( | ( (_| ( (/ /| |    "
    echo "(___/| ||_/ \_||_|\____)____)  |_|_| |_|\_/ \_||_|\____|\____)_|    "
    echo "     |_|                                                            "
    echo "...................................................................."
    echo ""
}

if [ "$#" -lt 1 ]; then
    print_banner
    echo -e "\nUse: $0 'YYYY-MM-DD'\n\nNote: The date must be a Sunday"
    exit
fi

INITIAL_DATE="$1"

SPACE_INVADER=(0 0 0 1 1 1 0
               0 0 1 1 0 0 0
               0 1 1 1 1 1 0
               1 1 0 1 1 0 1
               0 1 1 1 1 0 1
               0 1 1 1 1 0 0
               0 1 1 1 1 0 1
               1 1 0 1 1 0 1
               0 1 1 1 1 1 0
               0 0 1 1 0 0 0
               0 0 0 1 1 1 0)

git init
for index in ${!SPACE_INVADER[*]}
do
    if [ ${SPACE_INVADER[$index]} -eq 1 ]
    then
        echo "Commit for index: $index" >> commits.log
        git add commits.log
        git commit -m "Message for index $index"
        git commit --amend --no-edit --date="$(date -v+${index}d -jf "%Y-%m-%d" "$INITIAL_DATE" +"%Y-%m-%d 00:00:00")"
    fi
done
echo -e "\nDone!! Ready to push!!"

