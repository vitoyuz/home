#!/bin/sh

sudo=""

os=`uname -a | grep Darwin`
echo $os
if [ $os=="" ]
then
  echo "os is linux"
  sudo="sudo"
  $sudo apt-get install vim
  $sudo apt-get install zsh
  $sudo apt-get install ctags
else
  echo "os is osx"
fi

#zsh init
echo "zsh init"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
$sudo chsh -s /bin/zsh

#vim init
echo "vim init"
git clone https://github.com/gmarik/vundle.git  ~/.vim/bundle/vundle
vim -c BundleInstall &

