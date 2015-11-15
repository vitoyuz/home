#!/bin/sh

sudo=""

if [ `uname -a` | grep "Darwin" = "" ]
then
  echo "os is linux"
  sudo="sudo"
  $sudo apt-get install vim
  $sudo apt-get install zsh
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

