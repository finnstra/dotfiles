#!/usr/bin/env bash

# This script obtains and installs the desired version of Rekordbox. It will
# also clean up the download artifacts after installation is complete.

# Note: Finding Rekordbox installs is tricky, but I found ver 6 here: 
# https://rekordbox.com/en/support/faq/v6/#faq-q600141

# Use variables from the URL link. 
INSTALL_TARGET=Install_rekordbox_6_8_5.pkg
INSTALL_URL_DATE=20240416011027

install_rekordbox(){
  echo "-> Downloading rekordbox installer"
  wget "https://cdn.rekordbox.com/files/${INSTALL_URL_DATE}/${INSTALL_TARGET}_.zip"
  unzip "$INSTALL_TARGET"_.zip
  echo "-> Installing rekordbox"
  sudo installer -pkg $INSTALL_TARGET -target /
}

install_rekordbox

cleanup_rekordbox() {
  # Clean up
  echo "-> Cleaning up files"
  rm -rf "$INSTALL_TARGET"_.zip
  rm $INSTALL_TARGET
  echo "Installation of rekordbox complete, install artifacts cleaned up"
}

cleanup_rekordbox