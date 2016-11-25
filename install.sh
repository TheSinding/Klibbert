#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
KLIBBERT_DIR=$(pwd)
NO_MAIM=false;
NO_SLOP=false;
SOURCE="${BASH_SOURCE[0]}"
DIR=$(dirname $SOURCE)

declare -A osInfo;
osInfo[/etc/redhat-release]="yum -y install"
osInfo[/etc/arch-release]="pacman -Sy"
osInfo[/etc/debian_version]="apt-get install "

OS_INSTALL(){
  for f in ${!osInfo[@]}
  do
    if [[ -f $f ]];then
		  	${osInfo[$f]} $* || {
			 	if [ "$*" = "maim" ]; then 
								echo "Maim installtion failed"; 
								INSTALL_MAIM_SOURCE
				fi 
				if [ "$*" = "slop" ]; then
								echo "slop installtion failed";
								INSTALL_SLOP_SOURCE
				fi
		}
    fi
  done
}


INSTALL_MAIM_SOURCE(){
	echo "Installing Maim from source"
	echo "==========================="
	echo "Installing dependencies"
	OS_INSTALL libimlib2-dev libxrandr-dev libxfixes-dev
	echo "Cloning Maim"
	git clone https://github.com/naelstrof/maim.git /tmp/maim
	cd /tmp/maim
	echo "Building Maim"
	cmake ./
	make 
  make install
	cd $KLIBBERT_DIR
  printf "\n\n\n";
}

INSTALL_SLOP_SOURCE(){
	echo "Installing Slop from source"
	echo "==========================="
	echo "Installing dependencies"
	git clone https://github.com/naelstrof/slop.git /tmp/slop
	cd /tmp/slop
	echo "Building Slop"
	cmake -DCMAKE_OPENGL_SUPPORT=true ./
	make || { echo "Error: missing dependencies?";
   OS_INSTALL libxext-dev libimlib2-dev libxrender-dev libxrandr-dev libglew-dev libglm-dev
	 make
 }
  make install
	cd $KLIBBERT_DIR
  printf "\n\n\n";
}

INSTALL_KLIBBERT(){
	printf "Making klibbert executable"
	chmod +x $DIR/klibbert || { echo "An error ocurred. Aborting"; exit 1; }
	printf "... ${BOLD}Done\n"
	printf "Installing klibbert to /usr/local/bin/"
	cp $DIR/klibbert /usr/local/bin || { echo "An error ocurred. Aborting"; exit 1; }
	printf "... ${BOLD}Done\n"
	echo "Klibbert is now installed"
}

#Checking dependencies

hash cmake 2>/dev/null || {
	echo "CMake is required!"
	OS_INSTALL cmake
 }
#
hash maim 2>/dev/null || { NO_MAIM=true; }
hash slop 2>/dev/null || { NO_SLOP=true; }
#false
# Maim install

if $NO_MAIM; then
	echo "Maim is not installed, but it is required!"
	echo "Maim is used as a screenshot engine"
	echo "Do you wish to install Maim?"
	select yn in "Yes" "No"; do
 	   case $yn in
 	   		Yes ) OS_INSTALL maim; NO_MAIM=false; break;;
	       No ) echo "Bye"; exit;;
		  esac
	done
fi
# Slop install
if $NO_SLOP; then
	echo "Slop is not installed, and its needed to take screenshot of selected region"
	echo "It's optional, but highly recommended."
	echo "Do you wish to install Slop?"
	select yn in "Yes" "No"; do
 	   case $yn in
 	   		Yes ) OS_INSTALL slop; break;;
	       No ) echo "Not installing Slop"; break;;
		  esac
	done
fi

if ! $NO_MAIM; then
				INSTALL_KLIBBERT
fi
