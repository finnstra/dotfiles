#!/usr/bin/env bash

# This script obtains and installs the desired version of Rekordbox. It will
# also clean up the download artifacts after installation is complete.

# Note: Finding Rekordbox installs is tricky, but I found ver 6 here: 
# https://support.pioneerdj.com/hc/en-us/articles/8112764645785-I-want-to-use-previous-rekordbox-ver-6

echo "-> Downloading rekordbox"
wget "https://cdn.rekordbox.com/files/20240319174550/Install_rekordbox_6_8_4.pkg_.zip"
unzip Install_rekordbox_6_8_4.pkg_.zip
echo "-> Installing rekordbox"
sudo installer -pkg Install_rekordbox_6_8_4.pkg -target /

# Clean up
echo "-> Cleaning up files"
rm -rf Install_rekordbox_6_8_4.pkg_.zip
rm Install_rekordbox_6_8_4.pkg

echo "Installation of rekordbox complete, install artifacts cleaned up"