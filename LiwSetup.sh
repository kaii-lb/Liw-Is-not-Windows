#!/bin/bash

echo	"-i		To install the theme"
echo	"-u 		To uninstall the theme"


while getopts iu name
do
        case $name in
          i)iopt=1;;
          u)uopt=1;;
          *)echo "Invalid argument";;
        esac
done

if [[ ! -z $uopt ]]
then
	sudo rm -r ~/.themes/WhiteSur-light
	sudo rm -r ~/.icons/Win10Sur
	gnome-extensions uninstall arcmenu@arcmenu.com
	gnome-extensions uninstall appindicatorsupport@rgcjonas.gmail.com	
	gnome-extensions uninstall dash-to-panel@jderose9.github.com
fi
if [[ ! -z $iopt ]]
then
	sudo mkdir ~/.themes
	git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
	cd WhiteSur-gtk-theme
	bash ./install.sh
	gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-light"
	gsettings set org.gnome.shell.extensions.user-theme name "WhiteSur-light"
	cd ../


	sudo mkdir ~/.icons
	git clone https://github.com/yeyushengfan258/Win10Sur-icon-theme.git
	cd Win10Sur-icon-theme
	bash ./install.sh
	gsettings set org.gnome.desktop.interface icon-theme "Win10Sur"
	cd ../
	
	./install-gnome-extensions.sh --enable --file links.txt
fi

shift $(($OPTIND -1))
