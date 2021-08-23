#!/usr/bin/env bash 
# ------------------------------------------------------------------------ #
# Usage:         
#       $ inf 
# ------------------------------------------------------------------------ #
# Bash Version:  
#              GNU bash, versione 5.1.8(1)-release (x86_64-pc-linux-gnu)
#Copyright (C) 2020 Free Software Foundation, Inc.
#Licenza GPLv3+: GNU GPL versione 3 o successiva <http://gnu.org/licenses/gpl.html>
#
#This is free software; you are free to change and redistribute it.
#There is NO WARRANTY, to the extent permitted by law.
# ------------------------------------------------------------------------ #

function menuprincipal () {
clear
TIME=1
echo " "
echo Machine hardware informationsr
echo " "
echo "Choose an option below!
        1 - Verify desktop processor
	2 - Verify system kernel
	3 - Verify installed softwares
	4 - Operation system version
       	5 - Verify desktop memory
	6 - Verify serial number
	7 - Verify system IP	 
	0 - Exit"
echo " "
echo -n "Chosen option: "
read opcao
case $opcao in
	1)
		function processador () {
			CPU_INFO=`cat /proc/cpuinfo | grep -i "^model name" | cut -d ":" -f2 | sed -n '1p'`
			echo "CPU model: $CPU_INFO"
			sleep $TIME
		}	
		processador
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	2)
		function kernel () {
			#RED HAT: cat /etc/redhat-release
			KERNEL_VERSION_UBUNTU=`uname -r`
			KERNEL_VERSION_CENTOS=`uname -r`
			if [ -f /etc/lsb-release ]
			then
				echo "kernel version: $KERNEL_VERSION_UBUNTU"
			else
				echo "kernel version: $KERNEL_VERSION_CENTOS"
			fi
		}
		kernel
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	3)
		function softwares () {
			#while true; do
			TIME=3
			echo " "
			echo "Choose an option below for program's list!
			
			1 - List Ubuntu programs
			2 - List Fedora programs
			3 - List Arch programs
			4 - Back to menu"
			echo " "
			echo -n "Chosen option: "
			read alternative
			case $alternative in
				1)
					echo "Listing all programs Ubuntu's systems..."
					sleep $TIME
					dpkg -l > /tmp/programs.txt
					echo "Programs listed and available at /tmp/programs.txt"
					sleep $TIME
					echo " "
                                        echo "Back to menu!" | tr [a-z] [A-Z]
					sleep $TIME
					;;
				2)
					echo "Listing all programs Fedora's systems..."
					sleep $TIME
					yum list installed > /tmp/programs.txt
					echo "Programs listed and available at /tmp/programs.txt"
					echo " "
					echo "Back to menu!" | tr [a-z] [A-Z]
					sleep $TIME
					;;
				3)
					echo "Listing all programs Arch's systems..."
					sleep $TIME
					pacman -Q > /tmp/programs.txt
					echo "Programs listed and available at /tmp/programs.txt"
					sleep $TIME
					echo " "
					echo "Back to menu!" | tr [a-z] [A-Z]
					sleep $TIME
					;;
				4)
					echo "Back to main menu..."
					sleep $TIME
					;;	
			esac
		#done
		}		
		softwares
		menuprincipal
		;;
	
	4)
		function sistema () {
			VERSION=`cat /etc/os-release | grep -i ^PRETTY`
			if [ -f /etc/os-release ]
			then
				echo "The system version: $VERSION"
			else
				echo "System not supported"
			fi
		}
		sistema
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;


	5)
		function memory () {
			MEMORY_FREE=`free -m  | grep ^Mem | tr -s ' ' | cut -d ' ' -f 4`
			#MEMORY_TOTAL=
			#MEMORY_USED=
			echo "Verifying system memory..."
			echo "Memory free is: $MEMORY_FREE"	
		}
		memory
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	6)
		function serial () {
			SERIAL_NUMBER=`dmidecode -t 1 | grep -i serial`
			echo $SERIAL_NUMBER
		}
		serial
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	7)
		function ip () {
			IP_SISTEMA=`hostname -I`
			echo IP is: $IP_SISTEMA
		}
		ip
		read -n 1 -p "<Enter> for main menu"
		menuprincipal
		;;

	0) 
	       echo "Exiting the system..."
       	       sleep $TIME
	       exit 0
	       ;;

	*)
		echo "Invalid option, try again!"
		;;
esac
}
menuprincipal
