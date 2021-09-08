#!/bin/bash
xlight=$(xbacklight -get)
if [ ${xlight%%.*} -lt 85 ]
then
	xbacklight -inc 10
else
	xbacklight -set 97
fi
