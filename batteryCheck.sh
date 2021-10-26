# /bin/bash

BATTERY=`acpi | awk '{print $4}' | cut -c 1-2`
STATUS=`acpi | awk '{print $3}'| cut -c 1-4`

#Recommended values are between 30% and 75% at laptops batteries
MIN=30 
MAX=75

# Necessary for KDE because this desktop uses a security feature  
# --- Begin KDE ---
if [ $XDG_CURRENT_DESKTOP == "KDE" ]
then
        username=$(/usr/bin/whoami)
        pid=$(ps -u $username e | grep -m 1 DBUS_SESSION_BUS_ADDRESS | awk '{print $1}')
        dbus=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$pid/environ | sed 's/DBUS_SESSION_BUS_ADDRESS=//')
        export DBUS_SESSION_BUS_ADDRESS=$dbus
fi
# --- End KDE ---

if [[ $BATTERY -ge $MAX ]] && [[ $STATUS == "Char"  ]]
then
        DISPLAY=:0 && notify-send --urgency=critical  --expire-time=5000  -i /usr/share/icons/Adwaita/256x256/legacy/battery-full.pn "Battery is loaded with $BATTERY%!" "The laptop can be taken from the charging current!"
elif [[ $BATTERY -le $MIN ]] && [[ $STATUS == "Disc"  ]]
then
        DISPLAY=:0 && notify-send --urgency=critical  --expire-time=5000  -i /usr/share/icons/Adwaita/256x256/legacy/battery-caution.png "Battery has reached $BATTERY%!" "The laptop must be connected to the charging current!"
fi
exit
