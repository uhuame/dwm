#!/bin/bash
# Screenshot: http://s.natalian.org/2013-08-17/dwm_status.png
# Network speed stuff stolen from http://linuxclues.blogspot.sg/2009/11/shell-script-show-network-speed.html

# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
print_volume() {
	volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    VOL=$(amixer get Master | tail -n1 | awk '{print $6}' | tr -d '[]')
    echo -e "|Volume:${VOL}.${volume}"
}

print_mem(){
	memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	echo -e "|Memory:$memfree"
}

print_temp(){
	test -f /sys/class/thermal/thermal_zone0/temp || return 0
	echo $(head -c 2 /sys/class/thermal/thermal_zone0/temp)C
}

print_bat(){
    if $(acpi -b | grep --quiet Full)
    then
        echo "";
    else
	echo "|Battery:$(acpi -b | awk '{print $3}').$(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc)%";
    fi
}

print_date(){
	date '+%Y.%m.%d %A %H:%M'
}

print_xbacklight(){
    xlight=$(xbacklight -get)
    echo "|Light:${xlight%%.*}"
}
print_GPU(){
    GPU=$(optimus-manager --print-mode |sed -r 's/.*\: //')
    echo "|GPU:${GPU%%.*}"
}
show_record(){
	test -f /tmp/r2d2 || return
	rp=$(cat /tmp/r2d2 | awk '{print $2}')
	size=$(du -h $rp | awk '{print $1}')
	echo " $size $(basename $rp)"
}
show_sleep(){
    cat ~/scripts/status
}

#LOC=$(readlink -f "$0")
#DIR=$(dirname "$LOC")
#export IDENTIFIER="unicode"

#. "$DIR/dwmbar-functions/dwm_transmission.sh"
#. "$DIR/dwmbar-functions/dwm_cmus.sh"
#. "$DIR/dwmbar-functions/dwm_resources.sh"
#. "$DIR/dwmbar-functions/dwm_battery.sh"
#. "$DIR/dwmbar-functions/dwm_mail.sh"
#. "$DIR/dwmbar-functions/dwm_backlight.sh"
#. "$DIR/dwmbar-functions/dwm_alsa.sh"
#. "$DIR/dwmbar-functions/dwm_pulse.sh"
#. "$DIR/dwmbar-functions/dwm_weather.sh"
#. "$DIR/dwmbar-functions/dwm_vpn.sh"
#. "$DIR/dwmbar-functions/dwm_network.sh"
#. "$DIR/dwmbar-functions/dwm_keyboard.sh"
#. "$DIR/dwmbar-functions/dwm_ccurse.sh"
#. "$DIR/dwmbar-functions/dwm_date.sh"

#get_bytes

# Calculates speeds
#vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
#vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

xsetroot -name "$(show_sleep)$(print_mem)$(print_volume)$(print_GPU)$(print_xbacklight)$(print_bat) $(print_date) "

# Update old values to perform new calculations
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

exit 0
