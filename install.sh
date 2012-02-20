#!/bin/bash
mv $HOME/.vimrc $HOME/.vimrc.old
ln -s ./vimrc $HOME/.vimrc
mv $HOME/.vim $HOME/.vim.old
ln -s ./vim $HOME/.vim
mv $HOME/.zshrc $HOME/.zshrc.old
ln -s ./zshrc $HOME/.zshrc
mv $HOME/.gitconfig $HOME/.gitconfig.old
ln -s ./gitconfig $HOME/.gitconfig
mv $HOME/.Xresources $HOME/.Xresources.old
ln -s ./Xresources $HOME/.Xresources
if [ -d $HOME/.oh-my-zsh ]
then
   ln -s ./mine.zsh-theme $HOME/.oh-my-zsh/themes/mine.zsh-theme
else
   echo "Could not install mine.zsh-theme. Try installing oh-my-zsh if it isn't already installed."
fi
echo "If this is an Arch box running OpenBox and Xfce4, install xinitrc yourself."
