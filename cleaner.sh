#!/bin/bash

bold="\e[1m"
reset="\e[0m"

ask() {
    local prompt default reply

    if [[ ${2:-} = 'Y' ]]; then
        prompt='Y/n'
        default='Y'
    elif [[ ${2:-} = 'N' ]]; then
        prompt='y/N'
        default='N'
    else
        prompt='y/n'
        default=''
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty

        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

exists(){
	command -v "$1" >/dev/null 2>&1
}

pacmanClean(){
	echo -e "\n${bold}Removing all the cached packages that are not currently installed, and the unused sync database...${reset}"

	sudo pacman -Sc

	echo -e "\n${bold}Removing orphaned packages${reset}"

    sudo pacman -Rs $(pacman -Qtdq)

    echo -e "\n${bold}Removing cache of non installed packages${reset}"

	sudo paccache -r -u
}

dnfClean(){
	echo -e "\n${bold}Cleaning old kernel version${reset}"
	sudo dnf remove "$(dnf repoquery --installonly --latest-limit=-2 -q)"

	echo -e "\n${bold}Cleaning Fedora version cache${reset}"
	sudo dnf system-upgrade clean

	echo -e "\n${bold}Cleaning dnf packages cache and dnf cache${reset}"
	sudo dnf clean packages
	sudo dnf clean dbcache
}

aptClean(){
	echo -e "\n${bold}Cleaning apt / apt-get file${reset}"
	sudo apt clean
	sudo apt -s clean
	sudo apt clean all
	sudo apt autoremove
	sudo apt-get clean
	sudo apt-get -s clean
	sudo apt-get clean all
	sudo apt-get autoclean
}

gentooClean(){
    echo -e "\n${bold} Cleaning /var/tmp, /tmp, etc... ${reset}"
    
    sudo du -sh /var/tmp/portage/
    sudo du -sh /var/tmp/ccache/
    sudo du -sh /var/tmp/binpkgs/
    sudo du -sh /var/tmp/genkernel/
    sudo du -sh /tmp/
    sudo du -sh /var/cache/genkernel/

    if ask "Do you want to remove ?" Y; then
	    rm -rf /var/tmp/portage/*
        rm -rf /var/tmp/ccache/*
        rm -rf /var/tmp/binpkgs/*
        rm -rf /var/tmp/genkernel/*
        rm -rf /tmp/*
        rm -rf /var/cache/genkernel/*
	    echo -e "${bold}Done!${reset}\n"
    else
	    echo -e "\n${bold}Aborting...${reset}\n"
    fi

    echo -e "${bold} Cleaning unused libraries and programs... ${reset}"
    emerge -av --depclean
    emerge -cav

    echo -e "\n${bold} Checking for obselete packages... ${reset}"
    eix-test-obsolete

    
}

if exists pacman; then
	pacmanClean
elif exists dnf; then
	dnfClean	
elif exists apt; then
	aptClean
elif exists emerge; then
    gentooClean
fi

echo -e "\n${bold}Clean the cache in your $HOME directory ${reset}"

sudo du -sh ~/.cache/

echo ""

if ask "Do you want to remove ?" Y; then
	sudo rm -rf ~/.cache/*
	echo -e "${bold}Done!${reset}\n"
else
	echo -e "\n${bold}Aborting...${reset}\n"
fi

echo -e "\n${bold}Clean old journal logs ${reset}"

sudo du -sh /var/log/journal/

echo ""

if ask "Do you want to remove ?" Y; then
	sudo rm -rf /var/log/journal/*
	echo -e "${bold}Done!${reset}\n"
else
	echo -e "\n${bold}Aborting...${reset}\n"

fi

echo -e "\n${bold}Clean the trash${reset}"

sudo du -sh  $HOME/.local/share/Trash/

sudo du -sh /root/.local/share/Trash/

echo ""

if ask "Do you want to remove ?" Y; then
    rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
    rm -rf /root/.local/share/Trash/*/** &> /dev/null
    echo -e "${bold}Done!${reset}\n"
else
    echo -e "\n${bold}Aborting...${reset}\n"
fi

echo -e "\n${bold}Clean temp folders${reset}"

sudo du -sh /var/tmp/

sudo du -sh /tmp/

echo ""

if ask "Do you want to remove ?" Y; then
	sudo rm -rf /var/tmp/* /tmp/*
	echo -e "${bold}Done!${reset}\n"
else
	echo -e "\n${bold}Aborting...${reset}\n"
fi
