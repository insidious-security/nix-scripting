#!/bin/sh


#----Banner (Server) Hardening script for Linux.
printf "\n"
cat << "EOF"
 
    _____                              __  __               __           _            
   / ___/___  ______   _____  _____   / / / /___ __________/ /__  ____  (_)___  ____ _
   \__ \/ _ \/ ___/ | / / _ \/ ___/  / /_/ / __ `/ ___/ __  / _ \/ __ \/ / __ \/ __ `/
  ___/ /  __/ /   | |/ /  __/ /     / __  / /_/ / /  / /_/ /  __/ / / / / / / / /_/ / 
 /____/\___/_/    |___/\___/_/     /_/ /_/\__,_/_/   \__,_/\___/_/ /_/_/_/ /_/\__, /  
                                                                             /____/   
                          Insidious-Security
 
EOF

sleep 0.8
printf "Author: sidious \n"
sleep 0.8
printf " Code review : \n"
sleep 0.8
printf "\n"
printf "Version 1.0 \n"



#----Output formatter
error(){
  echo >&2 "$(tput bold; tput setaf 1)[-] ERROR: ${*}$(tput sgr0)"
}
warning(){
  echo >&2 "$(tput bold; tput setaf 1)[!] WARNING: ${*}$(tput sgr0)"
}
msg(){
  echo "$(tput bold; tput setaf 2)[+] ${*}$(tput sgr0)"
}


#----Check root privillege.
rootperm(){
  if [ "$(id -u)" -ne 0 ]; then
    error "you must be root"
	exit 1
  fi
}


#----Backup and write to sshd_config 
sshdcop(){
    cp /etc/ssh/sshd_config /etc/ssh/backup.sshd_config
    cat <<EOT >/etc/ssh/sshd_config    
    Protocol 2
    IgnoreRhosts yes
    HostbasedAuthentication no
    PermitRootLogin no
    PermitEmptyPasswords no
    X11Forwarding no
    MaxAuthTries 5
    ClientAliveInterval 900
    ClientAliveCountMax 0
    UsePAM yes
    HostKey /etc/ssh/ssh_host_ed25519_key
    HostKey /etc/ssh/ssh_host_rsa_key
    KexAlgorithms curve25519-sha256@libssh.org
    Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
    MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com
EOT
    systemctl restart sshd.service && systemctl status sshd.service > /dev/null 2>&1 
    
    if [ $? -eq 0 ]; then
        msg "SSH is hardened. SSH deamon is running.."
        SSHD_CHK=1
    else
        error "sshd_config file could not be hardened, check user permissions.. exiting.." && exit 1
    fi
}


#----Regen new ssh moduli
regenmod(){
	msg "Regenerating moduli candidates. This will take a few moments."
    ssh-keygen -M generate -O bits=2048 moduli-2048.candidates
    if [ $? -eq 0 ]; then msg "Stage 1 of generating moduli is completed"; else error "Stage 1 failed.. Exiting." && exit 1; fi
	msg "Starting Stage 2, almost there..."
    ssh-keygen -M screen -f moduli-2048.candidates moduli-2048
    if [ $? -eq 0 ]; then msg "Stage 2 of generating moduli is completed"; else error "Stage 2 failed.. Exiting." && exit 1; fi
    cp moduli-2048 /etc/ssh/moduli
    if [ -f /etc/ssh/moduli ]; then msg "Generated moduli-2048 copied to /etc/ssh/moduli" && rm moduli-2048; fi
	rm moduli-2048.candidates
    msg "Secure moduli candidates are now available.."
}


#----Set secure permissions for important system and configuration files. Need to change this to have error handling..
setperm(){
    chown root:root /etc/ssh/sshd_config
    chmod 600 /etc/ssh/sshd_config
    chown root:root /etc/anacrontab
    chmod og-rwx /etc/anacrontab
    chown root:root /etc/crontab
    chmod og-rwx /etc/crontab
    chown root:root /etc/cron.hourly
    chmod og-rwx /etc/cron.hourly
    chown root:root /etc/cron.daily
    chmod og-rwx /etc/cron.daily
    chown root:root /etc/cron.weekly
    chmod og-rwx /etc/cron.weekly
    chown root:root /etc/cron.monthly
    chmod og-rwx /etc/cron.monthly
    chown root:root /etc/cron.d
    chmod og-rwx /etc/cron.d
    chown root:root /etc/passwd
    chmod 644 /etc/passwd
    chown root:root /etc/group
    chmod 644 /etc/group
    chown root:root /etc/shadow
    chmod 600 /etc/shadow
    chown root:root /etc/gshadow
    chmod 600 /etc/gshadow
}


#----If Statement to get the party started...
if [ -f /etc/ssh/sshd_config ]; then
    rootperm && sshdcop
    if [ $SSHD_CHK -eq 1 ]; then setperm > /dev/null 2>&1; else warning "the SSHD service is not running properly." && exit 1; fi
    if [ $? -eq 0 ]; then regenmod; else error "permissions could not be managed by this script.." && exit 1; fi
fi

