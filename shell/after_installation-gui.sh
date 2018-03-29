#!/bin/bash

# Please ensure open this shell by using bash!!

# Clear Terminal
clear

# Get Present Working Directory
VIMRC_DIR=`pwd`
cd
HOME_DIR=`pwd`
DOWNLOAD_DIR=$HOME_DIR"/Downloads/"
IDE_INSTALL_DIR=$HOME_DIR"/.jetbrains/"

# Create GUI
GUI=$(zenity --list --checklist \
  --height="600" \
  --width="1000" \
  --title="Ubuntu Configure Tool" \
  --text="Choose items to get installed" \
  --column="Choice" --column="Operation"	--column="Description" \
  FALSE "Change Mirror" "Change to USTC mirror for better internet connection speed" \
  TRUE "Update" "Update and Upgrade" \
  TRUE "Install Build Essential" "Install Git CMake etc" \
  TRUE "Install zsh" "Replace bash by zsh and on-my-zsh" \
  TRUE "Install Lantern" "Install Lantern for Google Services" \
  TRUE "Install SSR" "" \
  TRUE "Install Sogou Pinyin" "Sogou Pinyin for chinese input"
  TRUE "Install Chrome" "Install Google Chrome for better Web surf experience" \
  TRUE "Install NetEase Music" "Install Netease Music" \
  TRUE "Install VScode" "Modern and fash Code Editor" \
  TRUE "Install CLion" "Install C/C++ IDE " \
  TRUE "Install Pycharm" "Install Python IDE" \
  FALSE "Install Android Studio" "Install Android Development IDE" \
  FALSE "Install OpenCV 3" "Auto Complie OpenCV3.2 and all additional package" \
  TRUE "Create .vimrc" "Update .vimrc for better code experience" \
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
	  cd $DOWNLOAD_DIR
  	wget -c https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb
    sudo dpkg -i lantern-installer-64-bit.deb
    sudo apt-get -y install -f
    rm -f lantern-installer-64-bit.deb
  fi
  
  # Install SSR
  if [[ $GUI == *"Install SSR"* ]]
  then
   clear
   echo "Installing Electron-SSR"
   echo ""
   cd $DOWNLOAD_DIR
   wget -c https://github.com/erguotou520/electron-ssr/releases/download/v0.2.2/electron-ssr_0.2.2_amd64.deb
   sudo dpkg -i electron-ssr_0.2.2_amd64.deb
   sudo apt-get -y install -f
   rm -f electron-ssr_0.2.2_amd64.deb
  fi

  # Install Sogou Pinyin
  if [[ $GUI == *"Install Sogou Pinyin"* ]]
  then
   clear
   echo "Installing Sogou Pinyin"
   echo ""
   cd $DOWNLOAD_DIR
   wget -c http://cdn2.ime.sogou.com/dl/index/1509619794/sogoupinyin_2.2.0.0102_amd64.deb
   sudo dpkg -i sogoupinyin_2.2.0.0102_amd64.deb
   sudo apt-get -y install -f
   rm -f sogoupinyin_2.2.0.0102_amd64.deb
  fi

  # Install Google Chrome
  if [[ $GUI == *"Install Chrome"* ]]
  then
    clear
  	echo "Installing Chrome"
  	echo ""
  	cd $DOWNLOAD_DIR
    sudo apt-get -y install flashplugin-installer
	  wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
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
	  cd $DOWNLOAD_DIR
  	wget -c http://s1.music.126.net/download/pc/netease-cloud-music_1.0.0_amd64_ubuntu16.04.deb
    sudo dpkg -i netease-cloud-music_1.0.0_amd64_ubuntu16.04.deb
    sudo apt-get -y install -f
    rm -f netease-cloud-music_1.0.0_amd64_ubuntu16.04.deb
  fi

  # Install VScode
  if [[ $GUI == *"Install VScode"* ]]
  then
   clear
   echo "Installing VScode"
   echo ""
   cd $DOWNLOAD_DIR
   wget -c https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
   sudo dpkg -i vscode.deb
   sudo apt-get -y install -f
   rm -f vscode.deb
  fi

  # Install CLion
  if [[ $GUI == *"Install CLion"* ]]
  then
    clear
  	echo "Installing CLion"
  	echo ""
    mkdir ~/.jetbrains
	  cd ~/Downloads
  	wget https://download.jetbrains.com/cpp/CLion-2018.1.tar.gz
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
  	wget https://download.jetbrains.com/python/pycharm-professional-2018.1.tar.gz
    tar zvxf ~/Downloads/pycharm-professional-2017.3.3.tar.gz -C $IDE_INSTALL_DIR
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
    wget -c https://github.com/opencv/opencv/archive/3.2.0.tar.gz -O opencv3.2.0.tar.gz
    wget -c https://github.com/opencv/opencv_contrib/archive/3.2.0.tar.gz -O opencv3.2.0-contrib.tar.gz
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
    cp $VIMRC_DIR/vimrc ~/.vimrc
  fi

  # Finish Notify
  clear
  notify-send -i utilities-terminal UbuntuConfigurator "Configured successfully!"

fi