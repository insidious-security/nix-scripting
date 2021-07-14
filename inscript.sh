#!/bin/bash

printf "\n"

cat << EOF

  ██ ███    ██ ███████ ████████  █████  ██      ██          ███████  ██████ ██████  ██ ██████  ████████ 
  ██ ████   ██ ██         ██    ██   ██ ██      ██          ██      ██      ██   ██ ██ ██   ██    ██    
  ██ ██ ██  ██ ███████    ██    ███████ ██      ██          ███████ ██      ██████  ██ ██████     ██    
  ██ ██  ██ ██      ██    ██    ██   ██ ██      ██               ██ ██      ██   ██ ██ ██         ██    
  ██ ██   ████ ███████    ██    ██   ██ ███████ ███████     ███████  ██████ ██   ██ ██ ██         ██    
                                        
                                            *Arch based systems only.                                                                                                   
                                                                                                    
EOF

sleep 1.4
printf "Author: sidious \n"
sleep 0.8
printf "\n"
printf "Version 1.0 \n"
printf "\n"

msg(){
  echo "$(tput bold; tput setaf 2)[+] ${*}$(tput sgr0)"
}


install_pkgs(){
    if pacman -Qi $1 &> /dev/null; then msg "$1 is already installed.."; else msg "Installing $1.." && sudo pacman -S --noconfirm --needed $1 > /dev/null 2>&1; fi
}


pkgs=(
nitrogen
thunar
picom
dmenu
vim
lxappearance
)

for sw in "${pkgs[@]}"; do
    install_pkgs $sw
done
