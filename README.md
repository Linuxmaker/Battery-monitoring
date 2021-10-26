# Battery-monitoring
Control of charging and unloading cycles of your laptop battery
Modern lithium-ion batteries do not like it when they are too fully charged or unloaded too empty. Ideally, the boost level of your battery should not be below 20 percent and not over 80 percent.
The script requires the packages ACPI and Libnotify-Bin, which deals with Debian, Ubuntu

apt-get install acpi libnotify-bin

install.

The script regularly tests the current charge status of the battery via a cronjob (e.g., every 5 minutes) 

chmod a+x /usr/local/bin/batteryCheck.sh

*/5 * * * * /usr/local/bin/batteryCheck.sh

and opens a notification window as soon as a limit (75% or 30%) has been reached. 

It works fine on Xfce and Gnome, but not on KDE. This is why the IF query must be run through with KDE, in which DBUS_SESSION_BUS_ADDRESS is changed for the executing user.
See also this blog https://www.linuxquestions.org/questions/slackware-14/kde-plasma-notifications-from-cron-4175692441/. 
