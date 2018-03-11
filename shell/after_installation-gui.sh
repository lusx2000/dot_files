#!/bin/bash

# Please ensure open this shell by using bash!!

# Clear Terminal
clear

# Get Present Working Directory
VIMRC_DIR=`pwd`
IDE_INSTALL_DIR="/home/lusx/.jetbrains/"

# Create GUI
GUI=$(zenity --list --checklist \
  --height="600" \
  --width="1000" \
  --title="Ubuntu Configure Tool" \
  --text="Choose items to get installed" \
  --column="Choice" --column="Operation"	--column="Description" \
  TRUE "Change Mirror" "Change to USTC mirror for better internet connection speed" \
  TRUE "Update" "Update and Upgrade" \
  FALSE "Install Build Essential" "Install Git CMake etc" \
  FALSE "Install zsh" "Replace bash by zsh and on-my-zsh" \
  FALSE "Install Lantern" "Install Lantern for Google Services" \
  FALSE "Install Chrome" "Install Google Chrome for better Web surf experience" \
  FALSE "Install NetEase Music" "Install Netease Music" \
  FALSE "Install CLion" "Install C/C++ IDE " \
  FALSE "Install Pycharm" "Install Python IDE" \
  FALSE "Install Android Studio" "Install Android Development IDE" \
  FALSE "Install OpenCV 3" "Auto Complie OpenCV3.2 and all additional package" \
  FALSE "Create .vimrc" "Update .vimrc for better code experience" \
  --separator="|");

if [[ $GUI ]]
then

  # Change Mirror
  if [[ $GUI == *"Change Mirror"* ]]
  then
    clear
  	echo "Changing"
  	echo ""
    sudo sed -i 's/cn.archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
    echo "Changed"
  fi

  # Update 
  if [[ $GUI == *"Update"* ]]
  then
    clear
  	echo "Updating"
  	echo ""
  	sudo apt-get -y update
  	sudo apt-get -y upgrade
  fi

  #Install Build Essential
  if [[ $GUI == *"Install Build Essential"* ]]
  then
    clear
  	echo "Installing Build Essential"
  	echo ""
    sudo apt-get -y install build-essential cgdb cmake git wget vim
  fi

  #Install zsh
  if [[ $GUI == *"Install zsh"* ]]
  then
    clear
  	echo "Installing Zshell"
  	echo ""
    sudo apt-get -y install zsh
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  fi

  # Install Lantern
  if [[ $GUI == *"Install Lantern"* ]]
  then
    clear
  	echo "Installing Lantern"
  	echo ""
	cd ~/Downloads
  	wget https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb
    sudo dpkg -i lantern-installer-64-bit.deb
    sudo apt-get -y install -f
    rm -f lantern-installer-64-bit.deb
  fi
  
  # Install Google Chrome
  if [[ $GUI == *"Install Chrome"* ]]
  then
    clear
  	echo "Installing Chrome"
  	echo ""
  	cd ~/Downloads
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt-get -y install -f
    rm -f google-chrome-stable_current_amd64.deb
  fi

  # Install NetEase Music
  if [[ $GUI == *"Install NetEase Music"* ]]
  then
    clear
  	echo "Installing NetEase Music"
  	echo ""
	  cd ~/Downloads
  	wget http://s1.music.126.net/download/pc/netease-cloud-music_1.0.0_amd64_ubuntu16.04.deb
    sudo dpkg -i netease-cloud-music_1.0.0_amd64_ubuntu16.04.deb
    sudo apt-get -y install -f
    rm -f netease-cloud-music_1.0.0_amd64_ubuntu16.04.deb
  fi

  # Install CLion
  if [[ $GUI == *"Install CLion"* ]]
  then
    clear
  	echo "Installing CLion"
  	echo ""
    mkdir ~/.jetbrains
	  cd ~/Downloads
  	wget https://download.jetbrains.com/cpp/CLion-2017.3.4.tar.gz
    tar zvxf ~/Downloads/CLion-2017.3.4.tar.gz -C $IDE_INSTALL_DIR
  fi

    # Install Pycharm
  if [[ $GUI == *"Install Pycharm"* ]]
  then
    clear
  	echo "Installing Pycharm"
  	echo ""
	  mkdir ~/.jetbrains
    cd ~/Downloads
  	wget https://download.jetbrains.com/python/pycharm-professional-2017.3.4.tar.gz
    tar zvxf ~/Downloads/pycharm-professional-2017.3.4.tar.gz -C $IDE_INSTALL_DIR
  fi
  
    # Install Android Studio
  if [[ $GUI == *"Install Android Studio"* ]]
  then
    clear
  	echo "Installing Android Studio"
  	echo ""
	  cd ~/Downloads
    sudo apt-get install python3-requests python3-bs4
	  cat > ~/Downloads/get_android_studio.py << _ANDROID_EOF
import requests
from bs4 import BeautifulSoup
import os
url = 'http://www.android-studio.org/'
r = requests.get(url, timeout=30)
r.encoding = r.apparent_encoding
soup = BeautifulSoup(r.text, 'html.parser')
a = []
for child in soup.tbody.children:
    a.append(child)
tr = a[-2]
a = []
for child in tr:
    a.append(child)
link = a[3].a.get('href')
os.system('wget {} -O android-studio.zip'.format(link))
_ANDROID_EOF
    python3 ~/Downloads/get_android_studio.py
    rm ~/Downloads/get_android_studio.py
    unzip ~/Downloads/android-studio.zip -d $IDE_INSTALL_DIR
  fi
  
  
  #Install OpenCV 3
  if [[ $GUI == *"Install OpenCV 3"* ]]
  then
    clear
  	echo "Downloading OpenCV 3"
  	echo ""
    mkdir ~/Documents/OpenCV
    cd ~/Documents/OpenCV
    sudo apt-get -y install aria2
    aria2c https://github.com/opencv/opencv/archive/3.2.0.tar.gz -o opencv3.2.0.tar.gz
    aria2c https://github.com/opencv/opencv_contrib/archive/3.2.0.tar.gz -o opencv3.2.0-contrib.tar.gz
    tar zvxf ~/Documents/OpenCV/opencv3.2.0.tar.gz
    tar zvxf ~/Documents/OpenCV/opencv3.2.0-contrib.tar.gz
    echo "Downloaded successfully"
    echo ""
    echo "Installing Dependencies Library"
    sudo apt-get -y install libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
    sudo apt-get -y install python3-dev python3-numpy libtbb2 libtbb-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
    cd ~/Documents/OpenCV/opencv-3.2.0
    mkdir build
    cd build
    cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_EXTRA_MODULES=~/Documents/OpenCV/opencv_contrib-3.2.0/modules -D CMAKE_INSTALL_PREFIX=/usr/local ..
    make -j4
    sudo make install
    echo "Install finished"

  fi


  #Update .vimrc
  if [[ $GUI == *"Create .vimrc"* ]]
  then
    clear
  	echo "Updating"
    sudo apt-get update
    sudo apt-get install git
    cp $VIMRC_DIR/vimrc ~/.vimrc
  fi

  # Finish Notify
  clear
  notify-send -i utilities-terminal UbuntuConfigurator "Configured successfully!"

fi

