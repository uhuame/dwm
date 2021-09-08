#!/bin/bash
if $(acpi -b | grep --quiet Charging)
then
	sudo cpupower frequency-set -g ondemand
else
	sudo cpupower frequency-set -g powersave
fi	
