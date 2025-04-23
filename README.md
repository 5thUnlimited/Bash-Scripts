# Bash-Scripts
This is my collection of Linux scripts that make life easier. They are mostly for mundane tasks that I found myself having to repeat constantly during normal Linux administration. They are written for Debian and Ubuntu machines but other distros should also work fine for the most part. 

# Setup
1. Add the folder they reside in to the $PATH and simply execute them from a shell.
2. For the most commonly used scripts, I have aliases set up in order to run them by typing just 3-4 keys.
4. Both of these steps are done with my personal .rc file I have saved for zsh and bash. There are a million ways to do it this but this method is quick when working with a fresh Linux install.


# Usage notes :

# ctl-system-cleanup
Beware as this will make permament changes and deletions to your device.

# ctl-map-touchscreen
Remaps a touchscreen monitor to the single screen when there is an additional external monitor attached. This fixes an issue where the touchscreen is misaligned and offset from the pointer. This bug occured on an Asus Zenbook and a Dell Inspiron using Debian 12. Other devices may or may not have this problem.

 # info-35-netfilter-status
For with the package IPtables-Persistent. To use, symlink to /usr/share/netfilter-perisistent/plugins.d/ and your IPtables policies and NAT rules will show up when saving firewall rules with "netfilter-perisistent save"

# info-autoconnect-on
This simply tells you if there are any NetworkManager connection profiles that are set to connect automatically. This prevents privacy issues from connecting inadverdently to an access point. This will check to see if there are any profiles with autoconnect on so it can be manually turned off or NetworkManager will re-connect when it sees that network in the future.

# info-vpn-monitor
This is set up and written for Mullvad VPN. 



