#! /bin/bash 

## script to automate some things that I with fresh installs to speed up the setup process. 

##I made this very quickly, and if it grows larger or more complex I might go back to actually break out each section into its own function

 
# test for root
if [ "$(id -u)" != 0 ]; then
  echo "Please run as root"
else
  root1=$(id -g -n 0)
fi

# determine username
user1=$(id -n -g 1000)
orig_dir=$(pwd)

# determine current hostname
orig_hostname=$(hostname)




# intro
echo ' ' 
echo ' '
echo 'This script automates some simple tasks that are done for each new machine or VM that is set up.'
echo "When finished, the changes that were made will be displayed on the screen

More changes are planned along with an interactive version for additional functionality."

# edit sudo timeout 
# **CAUTION these are usually for VMs that won't be used for daily long term use. Would not recommend such long sudo timeouts for most situations**
echo 'Defaults env_reset, timestamp_timeout=199' > /etc/sudoers.d/$user1


# Create useful folders inside the home directory along with keyboard shortcuts via aliases for quick navigation
mkdir -p /home/$user1/Documents/PC
mkdir -p /home/$user1/Documents/projects
mkdir -p /home/$user1/Documents/personal
mkdir -p /home/$user1/Documents/personal/wireless
mkdir -p /home/$user1/Documents/backups
mkdir -p /home/$user1/Downloads/linux_files
mkdir -p /home/$user1/Downloads/transfers


# Remove these folders as I never personally use them - other users may want to delete these commands to preserve the directories
rm -r /home/$user1/Pictures/
rm -r /home/$user1/Templates/
rm -r /home/$user1/Videos/
rm -r /home/$user1/Music/

#change to home dir and change owner from root to the new user
cd /home/$user1/
chown -R $user1:$user1 *

# edit ssh
ssh-keygen -t rsa -b 4096 -N "" 
echo "
AddressFamily inet
#ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config.d/sshd.conf

    
# Add all of the following aliases to the zshrc files

# add quick way to call root shell
echo "\n
alias r='sudo zsh'
" >> /$user1/.zshrc

echo "

# --------------------------------------------------------------------------
#     Additional Aliases
#     These are aliases that have been added by echo foo >> zsh config
#     Trying to keep files for root and user zsh config the same
# ---------------------------------------------------------------------------


# ------------------------------
#       NETWORKING ALIASES
# ------------------------------

alias hosts='nano /etc/hosts'

alias reso='nano /etc/resolv.conf'
alias resolo='echo '#changedmanually\nnameserver 127.0.0.1' > /etc/resolv.conf'
alias n='netstat -t -u -n -p'
alias nl='netstat -t -u -n -p -l'
alias cdnm='cd /etc/NetworkManager'
alias nmoff='nmcli networking off'
alias nmon='nmcli networking on'

alias macr0='macchanger -r -b wlan0'
alias macr1='macchanger -r -b wlan1'
alias macr2='macchanger -r -b wlan2'
alias macrall='macchanger -r -b wlan0;macchanger -r -b wlan1'

# ------------------------------
#       SYSTEM ALIASES
# ------------------------------

alias ll='ls -lAshp --group-directories-first '
alias la='ls -A --group-directories-first'
alias l='ls -CF --group-directories-first'


alias ssa='service --status-all'
alias ssar='service --status-all | grep +'

alias d='cd /home/$user1/Documents'
alias pc='cd /home/$user1/Documents/PC'
alias projects='cd /home/$user1/Documents/projects'

" > /home/$user1/.zshrc_TEMP


# add the commands above to user and root zshrc files
cat /home/$user1/.zshrc_TEMP >> /home/$user1/.zshrc
cat /home/$user1/.zshrc_TEMP >> /root/.zshrc
rm -r /home/$user1/.zshrc_TEMP 




# Outro
clear
echo "\n\n The following items have been done: \n\n"
echo "> New folders have been created in the user's home directory, located at /home/$user1"
echo "> New command aliases were added to zshrc file in the home directory. Use 'alias -L' to see all active aliases. This was done for the root zshrc file as well.""
echo "> Removed extra folders in home directory that I consider unneeded clutter"
echo "> Time before a sudo command prompts for the password again was extended [CAUTION! Be aware this is meant for temporary use VMs and similar siutuations]"
echo "> SSH options are changed to only use IPv4, and a 4096 bit RSA keypair is generated"
echo " "
echo "Finished"


