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
    cd tools
    sh ./get_current_tidepool_repos.sh
  fi

  popd	
}

function run {
  pushd /home/vagrant/tidepool/
  . tools/runservers
  popd
}

if [ ! -d "tidepool" ]; then
  read -n 1 -p "Fetch and set up tidepool repos? (Y/n) " answer1
  case ${answer1:0:1} in
    n|N )
      echo -e "\nPlease fetch the repos yourself.\n"
    ;;
    * )
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
      run
    ;;
  esac
fi
