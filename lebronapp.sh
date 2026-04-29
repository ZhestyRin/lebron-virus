#!/usr/bin/env bash
mkdir -p ~/lebronapp.app/contents
cd ~/lebronapp.app/contents
mkdir MacOS Resources

echo "<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>CFBundleIdentifier</key>
    <string>com.example.minimalapp</string>
    <key>CFBundleDisplayName</key>
    <string>MinimalApp</string>
    <key>CFBundleExecutable</key>
    <string>applet</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
</dict>
</plist>
" > info.plist

cd MacOS
echo "#!/usr/bin/env bash
tail -f /dev/null
" > applet
chmod +x applet

mkdir ~/lebron.iconset
sizes=(16 32 128 256 512)
for size in "${sizes[@]}"; do
        sips -z $size $size ~/lebron.png --out ~/Lebron.iconset/icon_${size}x${size}.png
        double_size=$((size * 2))
        sips -z $double_size $double_size ~/lebron.png --out ~/Lebron.iconset/icon_${size}x${size}@2x.png
done
iconutil -c icns ~/Lebron.iconset -o ~/lebronapp.app/contents/Resources/AppIcon.icns

touch ~/lebronapp.app
