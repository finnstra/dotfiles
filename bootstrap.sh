#!/usr/bin/env bash
# Script to setup a new machine. Do not run this as sudo, other
# scripts will not like this and refuse to run. Instead, run
# this script normally and allow the password prompts to
# run priviliged commands. 

# Set up logging environment
LOG_FILE='/Users/'$(logname)'/Desktop/install-log.log'

exec &> >(tee -a "$LOG_FILE")
echo "Logging to" $LOG_FILE

# EDIT THIS FIRST!
COMPUTER_NAME=yuuko # selamat pagi

# Force password entry after sleep
sudo defaults write com.apple.screensaver askForPassword 1 

echo "Enabling the firewall..."
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

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

echo "Computer renamed to: $COMPUTER_NAME ✅"

# Install oh-my-sh first, otherwise the terminal will look weird
echo "-> installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# run_chezmoi bootstraps chezmoi and runs it with our dotfiles
run_chezmoi() {
  echo " -> Running chezmoi"
  if ! command -v chezmoi >/dev/null; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply finnstra
  else
    chezmoi update
  fi
}

# Install homebrew
install_homebrew() {    
    echo " -> Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_homebrew

# Install Homebrew Path 
install_homebrew_path() {
  if [  -f /Users/$(logname)/.zprofile ]; then
    echo "Skipping path creation because .zprofile existed. Path is likely already created."
  else
    echo "zprofile not found. creating it to make brew work"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/brad/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

install_homebrew_path 