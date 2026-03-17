#!/bin/bash
sleep 2
pkill -x polybar
sleep 1
polybar main 2>&1 | tee -a /tmp/polybar.log & disown
