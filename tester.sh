#! bin/bash

NC='\033[0m' 
BLUE='\033[0;34m' 
RED='\033[0;31m'
VIOLET='\033[95m'
GREEN='\033[1;92m'
GRAY='\033[0;90m'

USER=$(whoami)

if [ $USER != "root" ];then
	echo "${RED}Opps! You don't have permission. Make sure you run the command with sudo permission - (sudo bash tester.sh)${RESET}\n\n";
	exit;
fi

echo "${VIOLET}=^..^=   =^..^=   =^..^= ABOUT YOUR VM  =^..^=    =^..^=    =^..^=${NC}\n\n"

echo "${VIOLET}What is a VM and what are the benefits of using VMs?\n${NC}"
echo "\n"
echo "${VIOLET}Why did you choose this OS?\n${NC}"
echo "\n"
echo "${VIOLET}What's the difference between the two OS's?\n${NC}"
echo "\n"
echo "${VIOLET}What's the difference between 'aptitude' and 'apt'?${NC}\n"

echo "${VIOLET}=^..^=   =^..^=   =^..^= SIMPLE CONFIG  =^..^=    =^..^=    =^..^=${NC}\n\n"

echo "${VIOLET}       GUI MODE CHECK:        ${NC}\n"
RES=$(ls/usr/bin*session)
if [[ $RES == "usr/bin/dbus-run-session" ]];then
	echo "${GREEN}YAY! GUI mode is disabled! OK ✔${NC}\n"
else
	echo "${RED}UH-OHH! GUI mode is enabled! KO ✗${NC}\n"
fi

echo "${VIOLET}       PASSWORD CHECK & HOSTNAME:        ${NC}\n"
sudo chage -l $USER

echo "\n"
echo "${VIOLET}       VM SETUP && PARTITIONS:        ${NC}\n"
echo "\n"
echo "${VIOLET}Chosen OS - Debian or Rocky:${NC}\n"
lsb_release -a || cat /etc/os-release
echo "\n"

echo "${GRAY}=====================================================================${NC}\n"

echo "${VIOLET}UFW Check:${NC}\n"

sudo ufw status
RES=$(sudo ufw status | grep -v ALLOW | grep active | wc -l)
if [ $RES -gt 0 ];then
        echo "${GREEN}YAY! Active. OK ✔${NC}\n"
  else
        echo "${RED}UH-OH! Not Active. KO ✗${NC}\n"
fi

echo "\n"

RES=$(sudo ufw status | grep 4242 | wc -l)
if [ $RES -gt 1 ];then
        echo "${GREEN}YAY! Port 4242 is open! OK ✔${NC}\n"
  else
        echo "${RED}UH-OH! Port 4242 is closed! KO ✗${NC}\n"
fi

echo "${GRAY}=====================================================================${NC}\n"

echo "${VIOLET}SSH Check:${NC}\n"

sudo service ssh status
RES=$(sudo service ssh status | grep "Active: active (running)" | grep "4242" | wc -l)
if [[ $RES -eq 1 ]]; then
	echo "${GREEN}YAY! SSH service is running on port 4242.${NC}\n"
else
	echo "${RED}UH-OH! SSH service is not running on port 4242.${NC}\n"
fi

# Check SSH root login
permit_root_login=$(sudo grep "PermitRootLogin" /etc/ssh/sshd_config | awk '{print $2}')
if [[ "$permit_root_login" == "no" ]]; then
	echo "${GREEN}YAY! Root login is disabled in SSH configuration.${NC}\n"
else
	echo "${RED}UH-OH! Root login is enabled in SSH configuration.${NC}\n"
fi

echo "\n"
cat /etc/ssh/sshd_config #| grep -E '^#?PermitRootLogin'  # Display the PermitRootLogin line
echo "\n"

echo "${GRAY}=====================================================================${NC}\n"
group_name ="evaluating"
user_name ="user42"

sudo user
