#!/bin/bash
sudo apt update
sudo apt -y install git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
