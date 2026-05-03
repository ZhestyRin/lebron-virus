#!/usr/bin/env bash
mkdir -p ~/lebronapp.app/contents
cd ~/lebronapp.app/contents
mkdir MacOS Resources

curl "https://raw.githubusercontent.com/Very-cool-guy/lebron-virus/main/resources/info.plist" > info.plist

cd MacOS
echo "#!/usr/bin/env bash
tail -f /dev/null
" > applet
chmod +x applet

curl "https://raw.githubusercontent.com/Very-cool-guy/lebron-virus/main/resources/AppIcon.icns" > ~/lebronapp.app/contents/Resources/AppIcon.icns

touch ~/lebronapp.app

# curl "https://raw.githubusercontent.com/Very-cool-guy/lebron-virus/main/lebronmenubar.sh" | bash
