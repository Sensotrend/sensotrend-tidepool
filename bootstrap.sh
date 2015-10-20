#!/usr/bin/env bash

echo "Update apt-get"
apt-get -q update
echo "Install curl"
apt-get install -y curl > curl.log
echo "Install git"
apt-get install -y git > git.log
