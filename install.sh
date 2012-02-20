#!/bin/bash
if [ -e $HOME/.vimrc ]
then
   if [ -h $HOME/.vimrc ]
   then
      rm $HOME/.vimrc
      echo "Removed symbolic link for .vimrc."
   else
      echo "vimrc not a symlink."
      mv $HOME/.vimrc $HOME/.vimrc.old
   fi
fi
ln -s ./vimrc $HOME/.vimrc

if [ -d $HOME/.vim ]
then
   mv $HOME/.vim $HOME/.vim.old
fi
ln -s ./vim $HOME/.vim

if [ -e $HOME/.zshrc ]
then
   mv $HOME/.zshrc $HOME/.zshrc.old
fi
ln -s ./zshrc $HOME/.zshrc

if [ -e $HOME/.gitconfig ]
then
   mv $HOME/.gitconfig $HOME/.gitconfig.old
fi
ln -s ./gitconfig $HOME/.gitconfig

if [ -e $HOME/.Xresources ]
then
   mv $HOME/.Xresources $HOME/.Xresources.old
fi
ln -s ./Xresources $HOME/.Xresources

if [ -d $HOME/.oh-my-zsh ]
then
   mv $HOME/.oh-my-zsh/themes/mine.zsh-theme $HOME/.oh-my-zsh/themes/mine.zsh-theme.old
   ln -s ./mine.zsh-theme $HOME/.oh-my-zsh/themes/mine.zsh-theme
else
   echo "Could not install mine.zsh-theme. Try installing oh-my-zsh if it isn't already installed."
fi
echo "If this is an Arch box running OpenBox and Xfce4, install xinitrc yourself."
