#!/usr/bin/env bash

echo "Fetching mongo packages"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

echo "Updating apt-get"
apt-get -qq update

echo "Installing htop..."
apt-get install -y htop > htop.log

echo "Installing node.js..."

curl --silent --location https://deb.nodesource.com/setup_0.12 | bash - > node.log
apt-get install -y nodejs >> node.log
apt-get install -y build-essential > node-tools.log

echo "Installing PhantomJS..."
# Installation of PhantomJS taken from https://gist.github.com/julionc/7476620
apt-get install build-essential chrpath libssl-dev libxft-dev > libs.log
apt-get install libfreetype6 libfreetype6-dev > freetype.log
apt-get install libfontconfig1 libfontconfig1-dev > fontconfig.log

cd ~
export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
wget -o phantomjs-fetch.log http://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2

tar xvjf $PHANTOM_JS.tar.bz2 >> phantomjs-fetch.log

mv $PHANTOM_JS /usr/local/share
ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

echo "Installing Gulp..."
npm install --global gulp > gulp.log
npm install --save-dev gulp > gulp-dev.log

echo "Installing Mocha..."
npm install -g mocha > mocha.log

echo "Installing Webpack..."
npm install -g webpack > webpack.log

echo "Installing MongoDB..."
apt-get install -y mongodb-org=2.6.5 mongodb-org-server=2.6.5 mongodb-org-shell=2.6.5 mongodb-org-mongos=2.6.5 mongodb-org-tools=2.6.5 > mongo.log

echo "Installing golang..."
wget -qO- https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar -C /usr/local/ -xzv > go.log
# Set PATH variable for Go
echo "export PATH=\$PATH:/usr/local/go/bin" > /etc/profile.d/golang.sh

# Reload bash profile so that go is present on PATH
source ~/.profile
source /etc/profile

echo "Installing bzr..."
apt-get install -y bzr > bzr.log

echo "Prerequisities installed."
