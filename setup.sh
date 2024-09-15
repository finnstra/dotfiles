#!/usr/bin/env bash
# This script is will install the Brew-related files on this machine.
# This should only be run after the bootstrap script has successfully
# ran. Otherwise the necessary files won't be here. 

# We're running this assuming the Brew file is in the directory
use_homebrew() {
    echo " -> Running homebrew"
    brew bundle install --file=~/Brewfile # Use the one given by Chezmoi in HOME directory
}

# use_homebrew

run_post_steps() {
    echo "-> running post-install steps"
    echo "enabling Apple Music --> Discord integration services"
    brew services restart apple-music-discord-rpc
    echo "Dev: Logging into Github CLI"
    gh auth login
    eval "$(ssh-agent -s)" # .ssh/config is already set up in Chezmoi.
    echo "DONE :D"
}
run_post_steps