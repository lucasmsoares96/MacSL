#!/bin/sh

## MacOS Configuration
cp ubuntu /usr/local/bin/ 
cp MacSL.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/MacSL.plist


## SSH
ssh-keygen -t rsa
cd .ssh
ssh-copy-id -p 2222 -i id_rsa.pub $USER@localhost

