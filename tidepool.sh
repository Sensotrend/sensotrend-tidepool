#!/usr/bin/env bash

# Add some convenient aliases for tidepool
alias tidepool-runservers='cd /home/vagrant/tidepool/ && . tools/runservers'
alias tidepool-update='cd /home/vagrant/tidepool/tools && sh ./update_current_tidepool_repos.sh'

function fetch {
  pushd /home/vagrant

  mkdir -p tidepool
  cd tidepool

  if [ -d "tools" ]; then
    echo "Skipping, because there is already a directory by that name."
  else
    git clone https://github.com/tidepool-org/tools.git
  fi
  cd tools
  sh ./get_current_tidepool_repos.sh

  popd	
}

function run {
  pushd /home/vagrant/tidepool/
  . tools/runservers
  popd
}

function chromeuploader {
  pushd /home/vagrant/tidepool/chrome-uploader
  # local development settings
  . config/local.sh
  npm install
  sh scripts/config.sh
  webpack -d
  mkdir -p /vagrant/chrome-uploader
  # copy only necessary files/folders
  cp -r build fonts images main.js index.html manifest.json /vagrant/chrome-uploader/
  popd
}


if [ ! -d "tidepool" ]; then
  read -n 1 -p "Fetch and set up tidepool repos? (Y/n) " answer1
  case ${answer1:0:1} in
    n|N )
      echo -e "\nPlease fetch the repos yourself.\n"
    ;;
    * )
      echo -e "\n"
      fetch
    ;;
  esac
fi

if [ -d "tidepool/tools" ]; then
  read -n 1 -p "Start the servers? (Y/n) " answer2
  case ${answer2:0:1} in
    n|N )
      echo -e "\nYou can start the services manually with 'tidepool-runservers'.\n"
    ;;
    * )
      echo -e "\n"
      run
      echo -e "\nThe services can be stopped with 'tp_kill'.\n"
    ;;
  esac
fi

if [ ! -d "/vagrant/chrome-uploader" ]; then
  if [ -d "tidepool/chrome-uploader" ]; then
    read -n 1 -p "build Chrome Uploader and transfer into shared vagrant folder? (Y/n) " answer3
    case ${answer3:0:1} in
      n|N )
        echo -e "\nYou can also build the uploader yourself and copy it to /vagrant dir that's shared with the host machine.\n"
      ;;
      * )
        echo -e "\n"
        chromeuploader
      ;;
    esac
  else
    echo "Check repository 'chrome-uploader' into /home/vagrant/tidepool/ to enable easy build & share to host machine."
  fi
fi
