#!/usr/bin/env bash

mkdir -p install-logs

echo "Fetching mongo packages"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

echo "Updating apt-get"
apt-get -qq update

echo "Installing htop..."
apt-get install -y htop > install-logs/htop.log

echo "Installing node.js..."

curl --silent --location https://deb.nodesource.com/setup_0.12 | bash - > install-logs/node.log
apt-get install -y nodejs >> install-logs/node.log
apt-get install -y build-essential > install-logs/node-tools.log

echo "Installing PhantomJS dependencies..."
# Installation of PhantomJS taken from https://gist.github.com/julionc/7476620
apt-get install build-essential chrpath libssl-dev libxft-dev > install-logs/libs.log
apt-get install libfreetype6 libfreetype6-dev > install-logs/freetype.log
apt-get install libfontconfig1 libfontconfig1-dev > install-logs/fontconfig.log

echo "Fetching PhantomJS..."
export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
curl --silent --location http://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 | tar xvj > install-logs/phantom-fetch.log

echo "Installing PhantomJS..."
mv $PHANTOM_JS /usr/local/share/$PHANTOM_JS
ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

echo "Installing Gulp..."
npm install --global gulp > install-logs/gulp.log
npm install --save-dev gulp > install-logs/gulp-dev.log

echo "Installing Mocha..."
npm install -g mocha > install-logs/mocha.log

echo "Installing Webpack..."
npm install -g webpack > install-logs/webpack.log

echo "Installing MongoDB..."
apt-get install -y mongodb-org=2.6.5 mongodb-org-server=2.6.5 mongodb-org-shell=2.6.5 mongodb-org-mongos=2.6.5 mongodb-org-tools=2.6.5 > install-logs/mongo.log

echo "Installing golang..."
wget -qO- https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar -C /usr/local/ -xzv > install-logs/go.log
# Set PATH variable for Go
echo "export PATH=\$PATH:/usr/local/go/bin" > /etc/profile.d/golang.sh

# Reload bash profile so that go is present on PATH
source ~/.profile
source /etc/profile

echo "Installing bzr..."
apt-get install -y bzr > install-logs/bzr.log

echo "Prerequisities installed."
