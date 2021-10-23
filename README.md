# Battery-monitoring
Control of charging and unloading cycles of your laptop battery
Modern lithium-ion batteries do not like it when they are too fully charged or unloaded too empty. Ideally, the boost level of your battery should not be below 20 percent and not over 80 percent.
The script requires the packages ACPI and Libnotify-Bin, which deals with Debian, Ubuntu

apt-get install acpi libnotify-bin

install.

The script regularly tests the current charge status of the battery via a cronjob (e.g., every 2 minutes) 

chmod a+x /usr/local/bin/batteryCheck.sh

*/2 * * * * /usr/local/bin/batteryCheck.sh

and opens a notification window as soon as a limit (80% or 20%) has been reached. 
