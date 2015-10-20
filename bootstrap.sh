#!/usr/bin/env bash

apt-get -q update
apt-get install -y curl > curl.log
apt-get install -y git > git.log
