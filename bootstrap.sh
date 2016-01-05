#!/usr/bin/env bash

echo "Update apt-get"
apt-get -q update
mkdir -p install-logs
echo "Install xorg"
apt-get install -y xorg > install-logs/xorg.log
echo "Install openbox"
apt-get install -y openbox > install-logs/openbox.log
echo "Install curl"
apt-get install -y curl > install-logs/curl.log
echo "Install git"
apt-get install -y git > install-logs/git.log
echo "Install chrome"
#apt-get install -y libxss1 libappindicator1 libindicator7 > install-logs/chrome-libs.log
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome*.deb > install-logs/chrome.log
#install the missing dependencies
#another way would be to install and use gdebi 
apt-get -f install -y
