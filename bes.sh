#!/bin/bash

#Colors
GREEN="\033[32m"
YELLOW="\033[33m"
PINK="\033[35m"
NORMAL="\033[0;39m"

# v1.0 BasicEnumerationScript
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
printf "$NORMAL \n"
printf "This script will perform a basic enumeration scan! \n"
printf "Today's a good day to pwn.\n"
printf "\n"
printf "$NORMAL \n"
sleep 0.4

##################################################################################################################

#VAR
DNE="not found!"

#Distribution info
DIST0="cat /etc/*release"
DIST1="uname -a"
printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"
printf "\n"
printf "`$DIST1 || $DNE`\n`$DIST0 || $DNE`"
printf "\n"
printf "\n"
sleep 0.4

#Networking
IPS="ip addr"
HOSTS="cat /etc/hosts"
printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"
printf "\n"
printf "`$HOSTS || $DNE`\n`$IPS | grep inet || $DNE`"
printf "\n"
printf "\n"
sleep 0.4

#Development tools
DEV[0]="gcc"
DEV[1]="python"
DEV[2]="python3"
DEV[3]="g++"
DEV[4]="perl"
DEV[5]="java"
DEV[6]="ruby"
printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"
printf "\n"
for i in "${DEV[@]}"
do
    printf "`which $i || echo $i $DNE`\n"
done
printf "\n"
sleep 0.4

#Users
US0="ps -au$user"
US1="cat /etc/passwd"
printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"
printf "\n"
$US0 || $DNE
printf "\n"
printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"
printf "\n"
$US1 || $DNE
printf "\n"
printf "$PINK------------------------------------------------------------------------------------------$NORMAL \n"

exit 0
