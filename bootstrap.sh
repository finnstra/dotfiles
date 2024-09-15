#!/usr/bin/env bash
# Script to setup a new machine.

# Set up logging environment
LOG_FILE='/Users/'$(logname)'/Desktop/install-log.log'

exec &> >(tee -a "$LOG_FILE")
echo "Logging to" $LOG_FILE

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