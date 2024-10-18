#!/bin/sh
dockutil --no-restart --remove all

dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Ableton Live 10 Suite.app"
dockutil --no-restart --add "/Applications/Google Chrome Beta.app"
dockutil --no-restart --add "/System/Applications/Music.app"
dockutil --no-restart --add "/Applications/Telegram.app"
dockutil --no-restart --add "/Applications/rekordbox 6/rekordbox.app"
dockutil --no-restart --add "/Applications/Discord.app"
dockutil --no-restart --add "/Applications/1Password.app"
dockutil --no-restart --add "/Applications/TickTick.app"

killall Dock

echo "dock configured."
