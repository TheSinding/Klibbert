#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
hash pastey 2>/dev/null || 
{ 
	dir=$(pwd)
	echo "Pastey is not installed, but it's required"
	echo "Installing it"
	echo "Cloning repo"
	git clone https://github.com/TheSinding/pastey /tmp/pastey
	cd /tmp/pastey
	echo "Installing Pastey"
	./install.sh
	cd $dir
}
printf "Making klibbert executable"
chmod +x klibbert
printf "... ${BOLD}Done\n"
printf "Installing klibbert to /usr/local/bin/"
cp klibbert /usr/local/bin
printf "... ${BOLD}Done\n"
echo "Klibbert is now installed"
