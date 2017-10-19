#!/bin/bash

replace () {
  FILE=".$1"
  if [ -e $HOME/$FILE ] && [ ! -L $HOME/$FILE ]
  then
    mv $HOME/$FILE $HOME/$FILE.old
  fi
  ln -sf $HOME/.dotfiles/$FILE $HOME/$FILE
}

replace_dir () {
  DIR=".$1"
  if [ -d $HOME/$DIR ] && [ ! -L $HOME/$DIR ]
  then
    mv $HOME/$DIR $HOME/$DIR.old
  fi
  ln -sf $HOME/.dotfiles/$DIR $HOME/$DIR
}

for file in "vimrc" \
  "zshrc" \
  "aliases" \
  "tmux.conf" \
  "gitconfig"; do
  replace "${file}"
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
ret

GIT_EMAIL="chrisbrenton@gmail.com"
git config --global user.name "Chris Brenton"
git config --global user.email "$GIT_EMAIL"

# Generate ssh key.
ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL"

# Start the ssh agent
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa

echo "If this is an Arch box running OpenBox and Xfce4, install xinitrc yourself."
