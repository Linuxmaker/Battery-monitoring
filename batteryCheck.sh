#!/bin/bash

BATTERY=`acpi | awk '{print $4}' | cut -c 1-2`
STATUS=`acpi | awk '{print $3}'| cut -c 1-4`
if [[ $BATTERY -ge 80 ]] && [[ $STATUS == "Char"  ]]
then
	DISPLAY=:0 notify-send --urgency=critical  --expire-time=5000  -i /usr/share/icons/Adwaita/256x256/legacy/battery-full.pn "Battery is loaded with $BATTERY%!" "The laptop can be taken from the charging current!"
elif [[ $BATTERY -le 40 ]] && [[ $STATUS == "Disc"  ]]
then	
	DISPLAY=:0 notify-send --urgency=critical  --expire-time=5000  -i /usr/share/icons/Adwaita/256x256/legacy/battery-caution.png "Battery has reached $BATTERY%!" "The laptop must be connected to the charging current!"
fi
exit
