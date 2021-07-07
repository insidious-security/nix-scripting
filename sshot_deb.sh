#!/bin/bash

#Colors
GREEN="\033[32m"
YELLOW="\033[33m"
PINK="\033[35m"
NORMAL="\033[0;39m"

# v1.2 SSH over Tor for debian based systems.
#################################################################################################################
printf "\n"
cat << "EOF"

  ━━━━━━━━━━━━━━┏┓━━━━━━━━━━━━━━
  ━━━━━━━━━━━━━━┃┃━━━━━━━━━━━━━━
  ┏┓┏━┓━┏━━┓┏┓┏━┛┃┏┓┏━━┓┏┓┏┓┏━━┓
  ┣┫┃┏┓┓┃━━┫┣┫┃┏┓┃┣┫┃┏┓┃┃┃┃┃┃━━┫
  ┃┃┃┃┃┃┣━━┃┃┃┃┗┛┃┃┃┃┗┛┃┃┗┛┃┣━━┃
  ┗┛┗┛┗┛┗━━┛┗┛┗━━┛┗┛┗━━┛┗━━┛┗━━┛
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


EOF

sleep 1.4
printf "URL: $GREEN https://insidious-security.com $NORMAL \n"
sleep 0.4
printf "Version: $YELLOW 1.0 $NORMAL \n"
sleep 0.4
printf "Author: $GREEN @sidious $NORMAL \n"
sleep 0.4
printf "Disclaimer: \n"
printf "$YELLOW \n"
printf "This script enables SSH over TOR...\n"
printf "Onion address will be displayed below..\n"
printf "$NORMAL \n"
printf "\n"
sleep 0.4


printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"
printf "\n"
apt update && apt install -y tor ; clear
printf "\n"
printf "Done installing TOR.... \n"
printf "\n"
sleep 0.8

echo -e "HiddenServiceDir /var/lib/tor/onion-ssh/\nHiddenServicePort 22 127.0.0.1:22" > /etc/tor/torrc
printf "Writing network configuration to the Torrc file \n"
sleep 1.4
printf "\n"
printf "Done..\n"
printf "\n"
printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"
printf "\n"
printf "Starting tor services \n"
sleep 1.4
printf "\n"
systemctl daemon-reload
sleep 0.4

/etc/init.d/tor restart
printf "\n"
printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"
printf "\n"
echo "Wait 20 seconds for Tor to start and generate the hostname" && sleep 20
printf "\n"
echo "You can now SSH to: " && cat /var/lib/tor/onion-ssh/hostname
printf "\n"
printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"
printf "\n"

exit 0
