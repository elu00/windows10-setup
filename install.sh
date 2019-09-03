#! /usr/bin/env bash
echo 'export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '\''{print $2}'\''):0' >> ~/.bashrc
echo 'bind '\''"\t":menu-complete'\''' >> ~/.bashrc
# neovim config

