#!/usr/bin/env bash
echocmd="cat /vagrant/provisioning/configs/welcome.txt"
bashrc=$(cat ~/.bashrc)

# Do not provision twice
if [[ "$bashrc" != *"$echocmd"* ]];
then
    echo "$echocmd" >> ~/.bashrc
fi