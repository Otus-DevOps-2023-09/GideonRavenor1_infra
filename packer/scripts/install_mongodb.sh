#!/bin/bash
until apt-get update 2>&1;
do
 sleep 2
done
until apt install mongodb -y 2>&1;
do
 sleep 2
done

systemctl start mongodb
systemctl enable mongodb
