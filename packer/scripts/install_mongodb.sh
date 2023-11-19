#!/bin/bash
apt update
sleep 10
apt install mongodb -y
systemctl start mongodb
systemctl enable mongodb
