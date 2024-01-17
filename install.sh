#!/usr/bin/env zsh

sudo cp ddns.sh /usr/local/bin/
sudo cp ddns.conf /etc/
sudo cp ddns.sh.service /etc/systemd/system/
sudo cp ddns.sh.timer /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable ddns.sh.timer
sudo systemctl start ddns.sh.timer
