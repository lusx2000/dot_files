#!/bin/bash

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
  cd ~
  echo "creating .vimrc"
	cat>~/.vimrc<< _VIM_EOF
"基本配置
syntax on 
syntax enable
set mouse=a
set mousehide
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
scriptencoding utf-8
"花括号匹配相关
inoremap { {}<ESC>i
inoremap {<CR> {<CR>}<ESC>O
set cursorline "高亮当前行
set number "行数
set autoindent "自动缩进
set smartindent "智能缩进
set cindent "C系列缩进
set softtabstop=4 "缩进长度
set shiftwidth=4 "缩进长度
set tabstop=4 "tab键长度
set expandtab "tab设为空格
set softtabstop=4 "缩进长度
set showmatch "自动匹配
set ruler "在右下角显示当前行信息
set incsearch "搜索加强
set hlsearch "搜索高亮
set guioptions-=T "一出工具栏
set showcmd "显示出输入的命令
set whichwrap=b,s,<,>,[,] " 光标从行首和行末时可以跳到另一行去
set history=1000 "历史记录条数从20到1000
set guioptions-=m "隐藏菜单栏
set ignorecase "搜索忽略大小写
filetype plugin indent on "自动检测文件类型并启动相关缩进插件
filetype plugin on "不同文件类型加载相应插件
filetype on "检查文件类型
set cmdheight=2 "命令行高度加1
" vim 自身命令行模式智能补全
set wildmenu

"按<F2>自动生成代码设置
if !exists("*SetTitlea")
map <F2> :call SetTitlea()<CR>
func SetTitlea()
let l = 0
let l = l + 1 | call setline(l,'#include <stdio.h>')
let l = l + 1 | call setline(l,'#include <stdlib.h>')
let l = l + 1 | call setline(l,'')
let l = l + 1 | call setline(l,'int main(int argc, char *argv[])')
let l = l + 1 | call setline(l,'{')
let l = l + 1 | call setline(l,'    return 0;')
let l = l + 1 | call setline(l,'}')
endfunc
endif



"按F5一键编译并运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
           exec "!gcc % -Wall -o   %<"
           exec "!time ./%<"
        elseif &filetype == 'cpp'
           exec "!g++ % -std=c++11 -Wall -o    %<"
           exec "!time ./%<"
        elseif &filetype == 'java'
           exec "!javac %"
           exec "!time java %<"
        elseif &filetype == 'sh'
           :!time bash %
        elseif &filetype == 'python'
        exec "!time python3 %"
        endif
endfunc

"按F6一键Debug
map <F6> :call Debug()<CR>
func! Debug()
	exec "w"
	if &filetype == 'c'
           exec "!gcc % -g -Wall -o   %<"
           exec "!cgdb ./%<"
        elseif &filetype == 'cpp'
           exec "!g++ % -g -std=c++11 -Wall -o  %<"
           exec "!cgdb ./%<"
	endif
endfunc
_VIM_EOF

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