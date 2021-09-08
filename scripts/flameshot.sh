#!/bin/bash
killall flameshot
if [ $? != 0 ];then
    flameshot 
fi
