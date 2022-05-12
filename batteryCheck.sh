#! /bin/bash

BATTERY=`acpi | awk '{print $4}' | cut -c 1-2`
STATUS=`acpi | awk '{print $3}'| cut -c 1-4`

# Recommended values are between 30% and 75% at laptops batteries
MIN=30 
MAX=75

# In the long term, the state of charge should be avoided below 20% and above 85%. 
MMIN=20
MMAX=85

# Necessary for KDE because this desktop uses a security feature  
# --- Begin KDE ---
username=$(/usr/bin/whoami)
pid=$(ps -u $username e | grep -m 1 DBUS_SESSION_BUS_ADDRESS | awk '{print $1}')
dbus=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$pid/environ | tr '\0' '\n' | sed 's/DBUS_SESSION_BUS_ADDRESS=//')
export DBUS_SESSION_BUS_ADDRESS=$dbus
# --- End KDE ---

if [ $BATTERY -ge $MAX ] && [ "$STATUS" = 'Char' ]
then
        DISPLAY=:0 /usr/bin/notify-send --urgency=normal  --expire-time=10000  -i /usr/share/icons/Adwaita/256x256/legacy/battery-full.png "Battery is loaded with $BATTERY%!" "Stop the charging process as the battery is leaving its optimal state of charge."
elif [ $BATTERY -le $MIN ] && [ "$STATUS" = 'Disc' ]
then
        DISPLAY=:0 /usr/bin/notify-send --urgency=normal  --expire-time=10000  -i /usr/share/icons/Adwaita/256x256/legacy/battery-caution-charging.png "Battery has reached $BATTERY%!" "Start the charging process as the battery has reached the optimum state of charge."
fi

if [ $BATTERY -ge $MMAX ] && [ "$STATUS" = 'Char' ]
then
        DISPLAY=:0 /usr/bin/notify-send --urgency=normal  --expire-time=10000  -i /usr/share/icons/Adwaita/256x256/legacy/battery-full-charging.png "Battery is loaded with $BATTERY%!" "Stop the charging process immediately to save the battery!"
elif [ $BATTERY -le $MMIN ] && [ "$STATUS" = 'Disc' ]
then
        DISPLAY=:0 /usr/bin/notify-send --urgency=normal  --expire-time=10000  -i /usr/share/icons/Adwaita/256x256/legacy/battery-caution.png "Battery has reached $BATTERY%!" "Start the charging process immediately to save the battery!"
fi
exit
