

### Intended for use on Debian based systems. You will need to make some changes in order to run on different Linux distros.
### Setup:    
#
#   1.  -  For users that need to be careful with what they are sending over the wire or with the radios on their device. No need to announce your prescence prematurely or connect when are where you didn't want to!
#           Simply turn of Network Manager with systemctl Stop --now NetworkManager and you will have the power to bring up your radios or ethernet ports using this script when you decide it is a good time. 
#
#   2.  -  Rename the interfaces whatever you want by dropping files in /etc/systemd/netowrk or using other methods of your choosing. 
#
#   3.  -  Setting this to run via an alias set to call a link in /usr/bin/ that points to where this is on your files sits. 
#
#          You now have the ability to bring all devices up, set custom txpower and region and be ready to connect, all in one keystroke.
#
#
# Note1:   This script will start Network Manager but will leave the network interface(s) down when it finishes. 
#          This is done intentionally as a way to maintain control over any and all traffic from you machine.
#          In order to bring the interface up use the ifconfig or IP commands. 
#
#
# Note2:  Requiring this script to run either on boot (which give you the same result as letting Systemd bring up the networking interfaces like ususal) or manually at the time of your chosing is an extra step
#         in the process of getting connected that most users don't want. As a result, Linux dsitributions across the board have gone with the default configuration of networking.service bringing up the network 
#         devices on boot to begin scanning for networks to connect to. Auto connect is ALSO on by defualt, and an even bigger security issue for privacy and security that leads to unintentional connections. 
#         It has happened to me and I have alway been frustrated that manually unchecking the autoconnect box is required for EVERY single network profile you want to configure that way. 
#         Suffice to say, for someone who needs to be cautious about everything they are sending from their device, I have concluded that it is better
#         and safer is the radio simply stays off until you decide you want to use it. This is a subject I could rant about endlessly but I'll leave it at that for now.

#! /usr/bin/bash


services () {

systemctl start networking.service
systemctl start NetworkManager

}

intsetup () {

systemctl status NetworkManager | cat | head -n 11

# make sure all devices are down
ifdown -a
ifconfig wlan0 down 2> /dev/null
ifconfig wl2 down 2> /dev/null 
ifconfig wl3 down 2> /dev/null 
ifconfig wl4 down 2> /dev/null 
ifconfig wl5 down 2> /dev/null

# set country, MAC, and txpower
iw reg set PA
macchanger -r -b wl2 2>/dev/null
macchanger -r -b wl3 2>/dev/null
macchanger -r -b wl4 2>/dev/null
macchanger -r -b wl5 2>/dev/null
iw wl2 set txpower fixed 2800 &>/dev/null
iw wl3 set txpower fixed 2800 &>/dev/null
iw wl4 set txpower fixed 2800 &>/dev/null
iw wl5 set txpower fixed 2800 &>/dev/null

}


statuses () {

clear 
echo '   
-- Setup complete --   


' 
sleep 1.5
echo '
Current Status:' 

#echo "\e[34m"Interfaces: "\e"
ip -c -br link
echo " "
#echo "\e[34m"NetworkManager Status: "\e"
systemctl status NetworkManager | grep running
echo '
  ------------------------------------------
     '
systemctl -n 0 status NetworkManager


echo " "
echo " "
#echo "\e[34m"Wireless Config: "\e"
iw dev | grep -A 6 -e Interface
}

services
intsetup
statuses
