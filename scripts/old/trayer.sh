#!/bin/bash
killall trayer
if [ $? != 0 ];then
	trayer --edge top --widthtype pixel --height 17 --transparent 30 --tint 55520
fi
