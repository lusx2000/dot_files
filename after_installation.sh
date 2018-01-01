#!/bin/bash

# Please ensure open this shell by using bash!!

# Clear Terminal
clear

# Create GUI
GUI=$(zenity --list --checklist \
  --height="600" \
  --width="1000" \
  --title="Debian" \
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
    sudo apt-get -y install build-essential cmake git wget vim
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
	cd ~/Downloads
  	wget https://download.jetbrains.com/cpp/CLion-2017.3.1.tar.gz
    sudo tar zvxf CLion-2017.3.1.tar.gz -C /usr/local
    sudo rm -f ~/Downloads/CLion-2017.3.1.tar.gz
  fi

    # Install Pycharm
  if [[ $GUI == *"Install Pycharm"* ]]
  then
    clear
  	echo "Installing Pycharm"
  	echo ""
	cd ~/Downloads
  	wget https://download.jetbrains.com/python/pycharm-professional-2017.3.2.tar.gz
    sudo tar zvxf pycharm-professional-2017.3.2.tar.gz -C /usr/local
    sudo rm -f ~/Downloads/pycharm-professional-2017.3.2.tar.gz
    sudo 
  fi
  
    # Install Android Studio
  if [[ $GUI == *"Install Android Studio"* ]]
  then
    clear
  	echo "Installing Android Studio"
  	echo ""
	cd ~/Downloads
  	wget https://dl.google.com/dl/android/studio/ide-zips/3.0.1.0/android-studio-ide-171.4443003-linux.zip
    sudo unzip android-studio-ide-171.4443003-linux.zip -d /usr/local
	sudo rm -f ~/Downloads/android-studio-ide-171.4443003-linux.zip
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
    cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_EXTRA_MODULES=~/Downloads/OpenCV/opencv_contrib-3.2.0/modules -D CMAKE_INSTALL_PREFIX=/usr/local ..
    make -j4
    sudo make install
    echo "Install finished"

  fi


  #Update .vimrc
  if [[ $GUI == *"Create .vimrc"* ]]
  then
    clear
  	echo "Updating"
	cd ~
	cat>~/.vimrc<<EOF
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
let l = l + 1 | call setline(l,'int main()')
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
           exec "!gdb ./%<"
        elseif &filetype == 'cpp'
           exec "!g++ % -g -std=c++11 -Wall -o  %<"
           exec "!gdb ./%<"
	endif
endfunc
EOF

  fi

  # Finish Notify
  clear
  notify-send -i utilities-terminal UbuntuConfigurator "Configured successfully!"

fi

