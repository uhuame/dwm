#!/bin/bash

bash ~/scripts/sleep.sh &
while true

do
	bash ~/scripts/dwm-status-refresh.sh
    sleep 0.1
done
