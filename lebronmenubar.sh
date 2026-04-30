#!/usr/bin/env bash

set -euo pipefail

cp -r ~/lebronapp.app ~/lebronappcopy.app
sips -z 22 22 ~/lebron.png --out ~/lebronappcopy.app/contents/Resources/icon.png

APP_BUNDLE="$HOME/lebronappcopy.app"
PLIST="$APP_BUNDLE/Contents/info.plist"
SWIFT_SRC="$APP_BUNDLE/Contents/MacOS/main.swift"
BINARY_NAME="$APP_BUNDLE/Contents/MacOS/$(defaults read "$PLIST" CFBundleExecutable)"

cat > "$SWIFT_SRC" << 'EOF'
import Cocoa
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let status = NSStatusBar.system
        statusItem = status.statusItem(withLength: NSStatusItem.squareLength)

        if let img = NSImage(named: NSImage.Name("icon")) {
            statusItem.button?.image = img
            statusItem.button?.imagePosition = NSControl.ImagePosition.imageOnly
        }

        let menu = NSMenu()
        menu.addItem(
            withTitle: "Run Script",
            action: #selector(runScript),
            keyEquivalent: ""
        )
        menu.addItem(NSMenuItem.separator())
        menu.addItem(
            withTitle: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )
        statusItem.menu = menu

        RunLoop.current.run()
    }

    @objc func runScript() {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/bin/bash")
        task.arguments = ["-c", "echo 'Hello from script!' | pbcopy"]
        try? task.run()
    }
}

let app = NSApplication.shared
app.delegate = AppDelegate()
app.setActivationPolicy(.accessory)
app.run()
EOF

xcrun swiftc \
    "$SWIFT_SRC" \
    -o "$BINARY_NAME" \
    -framework AppKit

chmod +x "$BINARY_NAME"

/usr/libexec/PlistBuddy -c "Add :LSUIElement bool true" "$PLIST" 2>/dev/null || \
    /usr/libexec/PlistBuddy -c "Set :LSUIElement true" "$PLIST"

touch ~/lebronappcopy.app
