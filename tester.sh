#! bin/bash

NC='\033[0m' 
BLUE='\033[0;34m' 
RED='\033[0;31m'
VIOLET='\033[95m'
GREEN='\033[1;92m'
GRAY='\033[0;90m'

USER=$(whoami)

# if [ $USER != "root" ];then
#	echo "${RED}Opps! You don't have permission. Make sure you run the command with sudo permission - (sudo bash tester.sh)${RESET}\n\n";
#	exit;
#fi

echo -e "${VIOLET}=^..^=   =^..^=   =^..^= ABOUT YOUR VM  =^..^=    =^..^=    =^..^=${NC}\n\n"

echo -e "${VIOLET}What is a VM and what are the benefits of using VMs?\n${NC}"
echo -e "${VIOLET}Why did you choose this OS?\n${NC}"
echo -e "${VIOLET}What's the difference between the two OS's?\n${NC}"
echo -e "${VIOLET}What's the difference between 'aptitude' and 'apt'?${NC}\n"

echo -e "${GRAY}=^..^=   =^..^=   =^..^= SIMPLE CONFIG  =^..^=    =^..^=    =^..^=${NC}\n"
echo -e "${GRAY}==================================================================${NC}\n"

echo -e "${VIOLET}       GUI MODE CHECK:        ${NC}\n"
RES=$(ls /usr/bin/*session)
if [[ $RES == "usr/bin/dbus-run-session" ]];then
	echo -e "${GREEN}YAY! GUI mode is disabled! OK ✔${NC}\n"
else
	echo -e "${RED}UH-OHH! GUI mode is enabled! KO ✗${NC}\n"
fi

echo -e "${VIOLET}       PASSWORD CHECK & HOSTNAME:        ${NC}\n"
sudo chage -l $USER

echo "\n"
echo -e "${VIOLET}       VM SETUP && PARTITIONS:        ${NC}\n"
echo "\n"
echo -e "${VIOLET}Chosen OS - Debian or Rocky:${NC}\n"
lsb_release -a || cat /etc/os-release
echo "\n"
hostnamectl

echo -e "${GRAY}==================================================================${NC}\n"

echo -e "${VIOLET}UFW Check:${NC}\n"

RES=$(sudo ufw status | grep -v ALLOW | grep active | wc -l)
if [ $RES -gt 0 ];then
        echo -e "${GREEN}YAY! Ufw is active. OK ✔${NC}\n"
  else
        echo -e "${RED}UH-OH! Not Active. KO ✗${NC}\n"
fi

RES=$(sudo ufw status | grep 4242 | wc -l)
if [ $RES -gt 1 ];then
        echo -e "${GREEN}YAY! Port 4242 is open! OK ✔${NC}\n"
  else
        echo -e "${RED}UH-OH! Port 4242 is closed! KO ✗${NC}\n"
fi

echo -e "${GRAY}Port 4545 is for the Bonus.${NC}\n"

sudo ufw status

echo -e "${GRAY}==================================================================${NC}\n"

echo -e "${VIOLET}SSH Check:${NC}\n"

echo -e "${GRAY}Ssh status${NC}"
RES=$(sudo service ssh status | grep "Active: active (running)" | grep "4242" | wc -l)
if [[ $RES -eq 1 ]]; then
	echo -e "${GREEN}YAY! SSH service is running on port 4242.${NC}\n"
else
	echo -e "${RED}UH-OH! SSH service is not running on port 4242.${NC}\n"
fi

sudo service ssh status

# Check SSH root login
echo -e "${GRAY}Root login check${NC}"
permit_root_login=$(sudo grep "PermitRootLogin" /etc/ssh/sshd_config | awk '{print $2}')
if [[ "$permit_root_login" == "no" ]]; then
	echo -e "${GREEN}YAY! Root login is disabled in SSH configuration.${NC}\n"
else
	echo -e "${RED}UH-OH! Root login is enabled in SSH configuration.${NC}\n"
fi

cat /etc/ssh/sshd_config | grep -E '^#?PermitRootLogin'  # Display the PermitRootLogin line

echo -e "${GRAY}=====================================================================${NC}\n"
group_name ="evaluating"
user_name ="user42"

sudo user
