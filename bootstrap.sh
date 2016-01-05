#!/usr/bin/env bash

echo "Update apt-get"
apt-get -q update
mkdir -p install-logs
echo "Install curl"
apt-get install -y curl > install-logs/curl.log
echo "Install git"
apt-get install -y git > install-logs/git.log
