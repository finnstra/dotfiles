#!/usr/bin/env bash
# Script to setup a new machine.

# Set up logging environment
LOG_FILE='/Users/'$(logname)'/Desktop/install-log.log'

exec &> >(tee -a "$LOG_FILE")
echo "Logging to" $LOG_FILE

# EDIT THIS FIRST!
COMPUTER_NAME=yuuko # selamat pagi

# Force password entry after sleep
defaults write com.apple.screensaver askForPassword 1 

echo "Enabling the firewall..."
defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Enable FilevVault
if [ "$(fdesetup status)" == "FileVault is On." ]; then
  echo "Disk encryption is enabled. 🔥"
fi

if [ "$(fdesetup status)" == "FileVault is Off." ]; then
  echo "Disk encryption not enabled. Enabling now..."
  fdesetup enable
fi

# Set computer name
echo "Changing computer name to: $COMPUTER_NAME"
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

echo "Computer renamed to: $COMPUTER_NAME"

# run_chezmoi bootstraps chezmoi and runs it with our dotfiles
run_chezmoi() {
  log " -> Running chezmoi"
  if ! command -v chezmoi >/dev/null; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply finnstra
  else
    chezmoi update
  fi
}

run_chezmoi

# After chezmoi syncs everything, we can have Homebrew install everything
install_homebrew() {    
    log " -> Installing homebrew"
    if ! command -v brew >/dev/null; then
      sh -c /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else  
      log "ERROR: Unable to install Homebrew...for some reason."
    fi
}

install_homebrew

use_homebrew() {
    log " -> Running homebrew"
    brew bundle --force cleanup # Sync to the Brewfile.
}

use_homebrew