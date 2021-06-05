#!/bin/bash

GREEN="\033[32m"
YELLOW="\033[33m"
PINK="\033[35m"
NORMAL="\033[0;39m"

# V1.0 SSH over TOR for ARCH based systems.
# Work in progress...
#######################################################################################################

printf "\n"
cat << "EOF"


              __                               ______      ____
   __________/ /_     ____ _   _____  _____   /_  __/___  / __ \
  / ___/ ___/ __ \   / __ \ | / / _ \/ ___/    / / / __ \/ /_/ /
 (__  |__  ) / / /  / /_/ / |/ /  __/ /       / / / /_/ / _, _/
/____/____/_/ /_/   \____/|___/\___/_/       /_/  \____/_/ |_|

				*Insidious Security
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
printf " -- Onion address will be displayed below..\n"
printf "$NORMAL \n"
printf "\n"
sleep 0.4


checkinst(){
	if [ $(which tor) -e "/usr/bin/tor" ]; then
		printf "$GREEN Tor already present, skipping installation \n"
	else
		yes | pacman -S tor 1>/dev/null 2>/dev/null
		if [ $(which tor) == "/usr/bin/tor" ]; then
			INST0=1
		else
			INST0=2
		fi
	fi
}


writeconf(){
	if [ $INST0 -eq 1 ]; then
		echo -e "HiddenServiceDir /var/lib/tor/onion-ssh/\nHiddenServicePort 22 127.0.0.1:22" > /etc/tor/torrc
		RESULT=1
	else
		printf "$RED Could not write to sshd_config \n"
		RESULT=2
	fi
}


servdeam(){
	systemctl deamon-reload && systemctl restart tor.service 1>/dev/null 2>/dev/null	
	printf "Wait 20 seconds for Tor to start and generate the hostname \n" && sleep 20
	printf "You can now SSH to: " && cat /var/lib/tor/onion-ssh/hostname
}


checkinst
if [ $? -eq 0 ]; then
	writeconf
	if [ $RESULT -eq 1 ]; then
		servdeam
	else
		#Something here
	fi
fi

