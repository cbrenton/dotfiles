#!/bin/bash

# Load info for this machine
. ./info.sh

if [ -z "$GIT_EMAIL" ]; then
  echo "Fill in info.sh then rerun this script."
  exit
fi

replace () {
  FILE=$(basename $1)
  FILE_DEST=".$FILE"
  if [ -e $HOME/$FILE_DEST ] && [ ! -L $HOME/$FILE_DEST ]
  then
    mv $HOME/$FILE_DEST $HOME/.$FILE.old
  fi
  ln -sf $1 $HOME/$FILE_DEST
}

replace_dir () {
  DIR=".$1"
  if [ -d $HOME/$DIR ] && [ ! -L $HOME/$DIR ]
  then
    mv $HOME/$DIR $HOME/$DIR.old
  fi
  ln -snf $HOME/.dotfiles/$1 $HOME/$DIR
}

for file in $PWD/configs/*; do
  replace $file
done

replace_dir "vim"

FOUND=false
omzDirs=( ".oh-my-zsh" ".omz" )
for OMZ in "${omzDirs[@]}"
do
   if [ -d $HOME/$OMZ ]
   then
      FOUND=true
      ln -sf $HOME/.dotfiles/resources/cbr.zsh-theme $HOME/$OMZ/themes/cbr.zsh-theme
      break
   fi
done
if [ ! $FOUND ]
then
   echo "Could not install cbr.zsh-theme. Try installing oh-my-zsh if it isn't already installed."
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Generate ssh key.
ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL"

# Start the ssh agent
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa

echo "If this is an Arch box running OpenBox and Xfce4, install xinitrc yourself."
