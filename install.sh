#!/bin/bash

# Load info for this machine
. ./info.sh

if [ -z "$GIT_EMAIL" ]; then
  echo "Fill in info.sh then rerun this script."
  exit
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

replace () {
  FILE=$(basename $1)
  FILE_DEST=".$FILE"
  if [ -e $HOME/$FILE_DEST ] && [ ! -L $HOME/$FILE_DEST ]
  then
    mv $HOME/$FILE_DEST $HOME/.$FILE.old
  fi
  ln -snf $1 $HOME/$FILE_DEST
}

for file in $PWD/configs/[^_]*; do
  replace $file
done

# @TODO: make this better
ln -snf $PWD/configs/_config/nvim $HOME/.config/nvim
ln -snf $PWD/configs/_plug.vim $HOME/.local/share/nvim/site/autoload/plug.vim

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
