#!/usr/bin/env bash

echo "Perform Update"
apt-get update

echo "Installing htop..."
apt-get install -y htop

echo "Installing node.js..."
#wget -qO- http://nodejs.org/dist/v0.12.1/node-v0.12.1-linux-x64.tar.gz | tar -C /usr/local --strip-components 1 -xzv

curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
apt-get install -y nodejs
apt-get install -y build-essential

# Modified from https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
#apt-get update
#apt-get install -y python-software-properties python g++ make
#add-apt-repository -y ppa:chris-lea/node.js
#apt-get -q update
#apt-get install -y nodejs

echo "Installing PhantomJS..."
# Installation of PhantomJS taken from https://gist.github.com/julionc/7476620
apt-get install build-essential chrpath libssl-dev libxft-dev
sudo apt-get install libfreetype6 libfreetype6-dev
sudo apt-get install libfontconfig1 libfontconfig1-dev

cd ~
export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
wget http://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2

sudo tar xvjf $PHANTOM_JS.tar.bz2

sudo mv $PHANTOM_JS /usr/local/share
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

echo "Installing Gulp..."
npm install --global gulp
npm install --save-dev gulp

echo "Installing Mocha..."
npm install -g mocha

echo "Installing Webpack..."
npm install -g webpack

echo "Installing MongoDB..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
apt-get -q update
apt-get install -y mongodb-org=2.6.5 mongodb-org-server=2.6.5 mongodb-org-shell=2.6.5 mongodb-org-mongos=2.6.5 mongodb-org-tools=2.6.5

echo "Installing golang..."
wget -qO- https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar -C /usr/local/ -xzv
# Set PATH variable for Go
echo "export PATH=\$PATH:/usr/local/go/bin" > /etc/profile.d/golang.sh

# Reload bash profile so that go is present on PATH
source ~/.profile
source /etc/profile

echo "Installing bzr..."
apt-get install -y bzr

echo "Cloning tidepool-tools..."
cd /home/vagrant
mkdir -p tidepool
cd tidepool
if [ -d "tools" ]; then
    echo "Skipping, because there is already a directory by that name."
else
    git clone https://github.com/tidepool-org/tools.git
fi

echo "Doing initial checkout..."
cd tools
sh ./get_current_tidepool_repos.sh

# Add some convenient aliases for tidepool
echo "alias tidepool-runservers='cd /home/vagrant/tidepool/ && . tools/runservers'" > /etc/profile.d/tidepool.sh
echo "alias tidepool-update='cd /home/vagrant/tidepool/tools && sh ./update_current_tidepool_repos.sh'" >> /etc/profile.d/tidepool.sh