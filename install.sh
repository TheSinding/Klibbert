#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
printf "Making klibbert executable"
chmod +x klibbert
printf "... ${BOLD}Done\n"
printf "Installing klibbert to /usr/local/bin/"
cp klibbert /usr/local/bin
printf "... ${BOLD}Done\n"
echo "Klibbert is now installed"
