#! /usr/bin/bash

# Bring up keepassxc or acrivate it if it's not running


xdotool windowactivate $(xdotool search --pid $(ps aux|grep keepass|grep -v grep|awk '{print $2}'))||keepassxc
