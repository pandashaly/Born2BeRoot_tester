#! bin/bash

NC='\033[0m' 
BLUE='\033[0;34m' 
RED='\033[0;31m'
VIOLET='\033[95m'
GREEN='\033[1;92m'
GRAY='\033[0;90m'
CYAN='\033[0;96m'

USER=$(whoami)

echo -e "${CYAN}    ____                  ___   ____       ____              __ ${NC}"
echo -e "${CYAN}   / __ \____  _________ |__ \ / __ \___  / __ \____  ____  / /_${NC}"
echo -e "${CYAN}  / __  / __ \/ ___/ __ \__/ // __  / _ \/ /_/ / __ \/ __ \/ __/${NC}"
echo -e "${CYAN} / /_/ / /_/ / /  / / / / __// /_/ /  __/ _, _/ /_/ / /_/ / /_  ${NC}"
echo -e "${CYAN}/_____/\____/_/  /_/ /_/____/_____/\___/_/ |_|\____/\____/\__/  by pandashaly${NC}\n\n"
                                                                

if [ $USER != "root" ];then
echo -e "${RED}Opps! You don't have permission.\nRun the command with sudo permission - (sudo bash tester.sh)${RESET}\n";
exit;
fi

neofetch

echo -e "${CYAN}=^..^=   =^..^=   =^..^= ABOUT YOUR VM  =^..^=    =^..^=    =^..^=${NC}\n"

echo -e "${VIOLET}What is a VM and what are the benefits of using VMs?\n${NC}"
# A software based emulation of a physical computer system, like a computer within a computer
# So a VM is an isolated environment separate from your main computer system and you can run
# different OS, softwares and run applications without affecting your maing computer.
echo -e "${VIOLET}Which OS did you chose and why?\n${NC}"
# Subject suggests Debian because it's free and user-friendly. It's community driven and 
# older than Rocky so it has more documentations and resources for troubleshooting.
echo -e "${VIOLET}What's the difference between Debian and Rocky?\n${NC}"
# Debian - community driven dev model which aims to be a universal OS - it adheres to (FPS) 
# Free software principles -freedom to run modify and update suftwares
# Rocky - led by Rocky entereprise foundation - it provides enterprise grade linux
# its designed and developed to meet the demands of larger scale businesses and organizations.
echo -e "${VIOLET}If you chose Debian, what's the difference between 'aptitude' and 'apt'?\nIf you chose Rocky, what are SELinux and DNF?${NC}\n"
# Aptitude - more advanced and interactive while apt is simpler and more straightforward
# Main difference - how they handle package dependencies (software needed for program to work)
# apt has shorter and easier to remember commands.

echo -e "${CYAN}=^..^=   =^..^=   =^..^=  =^..^=  =^..^=  =^..^=    =^..^=    =^..^=${NC}\n"
echo -e "${GRAY}==================================================================${NC}\n"

echo -e "${VIOLET}GUI MODE CHECK:        ${NC}\n"
RES=$(ls /usr/bin/*session)
if [[ $RES == "/usr/bin/dbus-run-session" ]]; then
	echo -e "${GREEN}YAY! GUI mode is disabled! OK ✔${NC}\n"
else
	echo -e "${RED}UH-OHH! GUI mode is enabled! KO ✗${NC}\n"
fi
echo -e "${GRAY}This test is looking for a specific executable (dbus-run-session) in the /usr/bin/ directory.\n
If the executable is found, it indicates that GUI mode is enabled,\n
and if it's not found, it suggests that GUI mode is disabled.\n
"dbus-run-session" is a command that can be used to start a D-Bus session,\n
often associated with running graphical applications in a session.${NC}\n"

# Check for Wayland
RES=$(ps aux | grep -E '(Xwayland|wayland)')

if [[ -n "$RES" ]]; then
	echo -e "${GREEN}YAY! Wayland is not detected! GUI mode is disabled! OK ✔${NC}\n"
else
	echo -e "${RED}UH-OHH! Wayland is detected. GUI mode might be enabled! KO ✗${NC}\n"
fi

echo -e "${GRAY}This test the presence of Weyland.\n
Wayland is used by default in Debian 10 and newer, older versions use Xorg by default.\n\n
Wayland is a modern display server replacing Xorg, known for better performance and security.\n
Checking for Wayland presence is a reliable indicator the presence of a GUI on Linux systems,\n
especially in Debian 12 where Wayland is the default display server for GNOME desktop environment.${NC}\n"

echo -e "${GRAY}==================================================================${NC}\n"

echo -e "${VIOLET}PASSWORD CHECK & HOSTNAME:        ${NC}\n"

echo -e "${VIOLET}{Password Policy:${NC}"
echo -e "${GRAY}$USER:${NC}\n"
sudo chage -l $USER

echo -e "${GRAY}root:${NC}\n"
sudo chage -l root
echo

echo -e "${VIOLET}GROUPS:        ${NC}\n"
groups | tr " " "\n"

echo -e "${GRAY}Create a new user add them to a group called 'evaluating'.${NC}"

# First, create a new user. Assign them a password of your choice, respecting the subject's rules. The evaluated person must now explain how they were able to implement the requested rules on their virtual machine. Normally, one or two files would have been modified.

# Now that you have a new user, ask the evaluated person to create a group named "evaluating" in front of you and assign it to this user. Finally, check that this user indeed belongs to the "evaluating" group.
# what is the purpose of this password policy, and advantages or disadvantages of it.

echo -e "${GRAY}==================================================================${NC}\n"

echo -e "${VIOLET}VM SETUP && PARTITIONS:        ${NC}\n"
echo -e "${VIOLET}Chosen OS - Debian or Rocky:${NC}"
# lsb_release -a || cat /etc/os-release
echo -e "${GRAY}*Command: hostnamectl${NC}"
hostnamectl

echo -e "${GRAY}Change this hostname by replacing the login with yours, then reboot the machine.\n
Command: sudo hostnamectl set-hostname <new_hostname>\n
Command: sudo reboot${NC}\n"

echo -e "${VIOLET}Partitions Check:${NC}"

# This part is an opportunity to discuss partitions! The evaluated person must give you a brief explanation of how LVM works and why it's beneficial.

# What are partitions and how does LVM work

RES=$(lsblk | grep lvm | wc -l)
if [ $RES -gt 1 ];then
  echo -e "${GREEN}[OK] ✔${GRAY} lvm${NC}"
else
	echo -e "${RED}[KO] ✗${GRAY} no lvm partition${NC}"
fi
RES=$(lsblk | grep home | wc -l)
if [ $RES -gt 0 ];then
	echo -e "${GREEN}[OK] ✔${GRAY} home${NC}"
else
	echo -e "${RED}[KO] ✗${GRAY} no home partition${NC}"
fi
RES=$(lsblk | grep swap | wc -l)
if [ $RES -gt 0 ];then
	echo -e "${GREEN}[OK] ✔${GRAY} swap${NC}"
else
	echo -e "${RED}[KO] ✗${GRAY} no swap partition${NC}"
fi
RES=$(lsblk | grep root | wc -l)
if [ $RES -gt 0 ];then
	echo -e "${GREEN}[OK] ✔${GRAY} root${NC}\n"
else
	echo -e "${RED}[KO] ✗${GRAY} no root partition${NC}\n"
fi

echo -e "${VIOLET}Bonus Partitions:${NC}"

RES=$(lsblk | grep var | wc -l)
if [ $RES -gt 0 ];then
  echo -e "${GREEN}[OK] ✔${GRAY} var${NC}"
else
	echo -e "${RED}[KO] ✗${GRAY} no var partition${NC}"
fi
RES=$(lsblk | grep srv | wc -l)
if [ $RES -gt 0 ];then
	echo -e "${GREEN}[OK] ✔${GRAY} srv${NC}"
else
	echo -e "${RED}[KO] ✗${GRAY} no srv partition${NC}"
fi
RES=$(lsblk | grep tmp | wc -l)
if [ $RES -gt 0 ];then
	echo -e "${GREEN}[OK] ✔${GRAY} tmp${NC}"
else
	echo -e "${RED}[KO] ✗${GRAY} no tmp partition${NC}"
fi
RES=$(lsblk | grep var--log | wc -l)
if [ $RES -gt 0 ];then
	echo -e "${GREEN}[OK] ✔${GRAY} var--log${NC}\n"
else
	echo -e "${RED}[KO] ✗${GRAY} no var--log${NC}\n"
fi

echo -e "${GRAY}*Command: lsblk${NC}"
lsblk
echo

echo -e "${GRAY}==================================================================${NC}\n"

# SUDO

# Verify that the "sudo" program is indeed installed on the virtual machine.</li> The evaluated person must now show how to assign your new user to the "sudo" group.</li>
# The subject imposes strict rules for sudo. The evaluated person must first explain the purpose and operation of sudo with examples of their choice. Then, they must demonstrate the implementation of the rules imposed by the subject.</li>
# Verify that the "/var/log/sudo/" directory exists and contains at least one file. Check the contents of the files in this directory; you should see a history of commands used with sudo. Finally, attempt to run a command via sudo. Check if the file(s) in the "/var/log/sudo/" directory have been updated. If something does not work as expected or is not clearly explained, the evaluation stops here.

echo -e "${VIOLET}UFW Check:${NC}\n"

echo -e "${CYAN}What is UFW? - Why is it important?${NC}"
# Uncomplicated Firewall - interface that modifies the fw without compromising security
# Used to configure which ports to allow connections and which ports to close
echo -e "${GRAY}Add new rule to open port 8080. \nList active rules\nDelete port 8080${NC}\n"

RES=$(sudo ufw status | grep -v ALLOW | grep active | wc -l)
if [ $RES -gt 0 ];then
        echo -e "${GREEN}YAY! Ufw is active. OK ✔${NC}"
  else
        echo -e "${RED}UH-OH! Not Active. KO ✗${NC}"
fi

RES=$(sudo ufw status | grep 4242 | wc -l)
if [ $RES -gt 1 ];then
        echo -e "${GREEN}YAY! Port 4242 is open! OK ✔${NC}"
  else
        echo -e "${RED}UH-OH! Port 4242 is closed! KO ✗${NC}"
fi

echo -e "${GRAY}*Note: Port 4545 is for the Bonus.${NC}\n"

echo -e "${GRAY}*Command: sudo ufw status${NC}"
sudo ufw status

echo -e "${GRAY}==================================================================${NC}\n"

echo -e "${VIOLET}SSH Check:${NC}\n"

echo -e "${CYAN}What is SSH and why is it important?${NC}"
echo -e "${GRAY}Use SSH to connect with the new user created.${NC}\n"

# Check if SSH is installed
if [ -x "$(command -v ssh)" ]; then
	echo -e "${GREEN}YAY! SSH is installed. ✔${NC}\n"
else
	echo -e "${RED}UH-OH! SSH is not installed. ✗${NC}\n"
fi

echo -e "${VIOLET}SSH status check${NC}"
if sudo service ssh status | grep -q "Active: active (running)"; then
    echo -e "${GREEN}YAY! SSH service is running. ✔${NC}\n"
else
    echo -e "${RED}UH-OH! SSH service is not running. ✗${NC}\n"
fi

# Check SSH status and port
echo -e "${VIOLET}Ssh status${NC}"
RES=$(sudo lsof -i -P -n | grep sshd | grep LISTEN | grep 4242 | wc -l)
if [ $RES -gt 1 ];then
	echo -e "${GREEN}YAY! SSH service is running only on port 4242. ✔${NC}\n"
else
	echo -e "${RED}UH-OH! SSH service is not running only on port 4242. ✗${NC}\n"
fi

# Check SSH root login
echo -e "${VIOLET}Root login check${NC}"
permit_root_login=$(sudo grep "^PermitRootLogin" /etc/ssh/sshd_config | awk '{print $2}')
if [[ "$permit_root_login" == "no" ]]; then
	echo -e "${GREEN}YAY! Root login is disabled in SSH configuration. ✔${NC}\n"
else
	echo -e "${RED}UH-OH! Root login is enabled in SSH configuration. ✗${NC}\n"
fi

echo -e "${GRAY}*Command: sudo service ssh status${NC}"
sudo service ssh status
echo
echo -e "${GRAY}=====================================================================${NC}\n"
# Display SSH Configuration
echo -e "${GRAY}SSH Config:${NC}"
cat /etc/ssh/sshd_config | grep -E '^#?PermitRootLogin'  # Display the PermitRootLogin line
echo -e "${GRAY}Port Config:${NC}"
cat /etc/ssh/sshd_config | grep -E '^#?Port'  # Display the Port line
echo -e "${GRAY}*Command: cat /etc/ssh/sshd_config${NC}"

echo -e "${GRAY}=====================================================================${NC}\n"
# group_name ="evaluating"
# user_name ="user42"

# sudo user
echo -e "${VIOLET}CHRON - Script Monitoring:${NC}\n"
echo -e "${CYAN}What is cron?${NC}"
echo -e "${GRAY}Change it so that it runs every minute.${NC}\n"

RES=$(crontab -l | grep monitoring.sh | awk '$1 == "*/10" {print $1}')
if [ $RES == "*/10" ];then
	echo -e "${GREEN}YAY! Cron job frequency is set to every 10 minutes. ✔${NC}\n"
else
	echo -e "${RED}UH-OH! Cron job frequency is not set to every 10 minutes. ✗${NC}\n"
fi

echo -e "${GRAY}*Command: cat /usr/local/bin/monitoring.sh${NC}"
cat /usr/local/bin/monitoring.sh
echo
echo -e "${GRAY}*Command: sudo crontab -l${NC}"
echo -e "${GRAY}*To edit: sudo VISUAL=vim crontab -e${NC}"
sudo crontab -l
echo
echo -e "${GRAY}=====================================================================${NC}\n"

echo -e "${GRAY}=====================================================================${NC}\n"
echo -e "${VIOLET}BONUS${NC}\n"
echo -e "${VIOLET}Website Url:${NC}"
http://localhost:4545/
echo



# BONUS 
# Partitions
# Wordpress site
# The setup of WordPress, with only the services listed in the subject, will be worth 2 points</li>
# The free-choice service will be worth 1 point. Verify and test the proper functioning and implementation of each additional service. For the free-choice bonus service, the evaluated person must provide a simple explanation of the service and explain the reasons for their choice. Be aware: NGINX and Apache2 are forbidden.
