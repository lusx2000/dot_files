#!/bin/bash


vimrcdir=`pwd`

function changeMirror {
  sudo sed -i 's/cn.archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
  echo "changed to USTC mirrors"
  return
}

function update {
  echo "Updating"
  sudo apt-get -y update
  sudo apt-get -y upgrade
  return 
}

function installBuildEssential {
  echo "Installing Build Essential"
  sudo apt-get -y install build-essential cgdb cmake git wget vim
  return 
}

function installZshell {
  echo "Installing ZShell"
  sudo apt-get -y install zsh
  echo "Installing Oh-my-zsh"
  sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  return
}

function installLantern {
  cd ~/Downloads
  echo "Downloading lantern"
  wget https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb
  echo "Installing lantern"
  sudo dpkg -i lantern-installer-64-bit.deb
  sudo apt-get -y install -f
  rm -f lantern-installer-64-bit.deb
  return 
}

function installGoogleChrome {
  cd ~/Downloads
  echo "Downloading Chrome"
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  echo "Installing Chrome"
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt-get -y install -f
  rm -f google-chrome-stable_current_amd64.deb
  return
}

function installNetEaseMusic {
  cd ~/Downloads
  echo "Downloading NetEase Music"
  wget http://s1.music.126.net/download/pc/netease-cloud-music_1.0.0_amd64_ubuntu16.04.deb
  echo "Installing NetEase Music"
  sudo dpkg -i netease-cloud-music_1.0.0_amd64_ubuntu16.04.deb
  sudo apt-get -y install -f
  rm -f netease-cloud-music_1.0.0_amd64_ubuntu16.04.deb
  return
}

function installAndroidStudio {
 	echo "Installing Android Studio"
	cd ~/Downloads
  sudo apt-get install python3-requests python3-bs4
	
# Using a python webcrawler to get latest Android Studio 
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
  sudo unzip ~/Downloads/android-studio.zip -d /usr/local
  rm ~/Downloads/android-studio.zip
  /usr/local/android-studio/bin/studio.sh 
  return 
}


function installOpenCV {

# Using OpenCV3.2 with extra modules 
  echo "Downloading OpenCV 3"
  mkdir ~/Documents/OpenCV
  cd ~/Documents/OpenCV
  wget https://github.com/opencv/opencv/archive/3.2.0.tar.gz -O opencv3.2.0.tar.gz
  wget https://github.com/opencv/opencv_contrib/archive/3.2.0.tar.gz -O opencv3.2.0-contrib.tar.gz
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
  return
}

function createVimConf {
  echo "creating .vimrc"
  cp $vimrcdir/vimrc ~/.vimrc
  return 
}

clear
echo "
Simple Configurator for Ubuntu :
A.  ChangeMirror
B.  Update & Upgrade
C.  Install Build Essential packages 
D.  Install ZShell
E.  Install Lantern
F.  Install Google Chrome
G.  Install NetEase Music
H.  Install Android-Studio
I.  Install OpenCV 3.2
J.  Create .vimrc

0. Quit
"

read -p "Enter one or more (defalut = all)> " 

if [ "$REPLY" == "" ]; then
  REPLY="all"
fi

if [ "$REPLY" == "all" ]; then
  REPLY="a b c d e f g h i j"
fi

echo "Your option is : $REPLY"

# something wrong with case select
case $REPLY in
  "0") exit ;;&
  "a"|"A") changeMirror ;;&
  "b"|"B") update ;;&
  "c"|"C") installBuildEssential ;;&
  "d"|"D") installZshell ;;&
  "e"|"E") installLantern ;;&
  "f"|"F") installGoogleChrome ;;&
  "g"|"G") installNetEaseMusic ;;&
  "h"|"H") installAndroidStudio ;;&
  "i"|"I") installOpenCV ;;&
  "j"|"J") createVimConf ;;&
esac 
