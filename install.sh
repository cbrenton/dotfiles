#!/bin/bash
if [ -e $HOME/.vimrc ] && [ ! -L $HOME/.vimrc ]
then
   mv $HOME/.vimrc $HOME/.vimrc.old
fi
ln -sf $HOME/.dotfiles/vimrc $HOME/.vimrc

if [ -d $HOME/.vim ] && [ ! -L $HOME/.vim ]
then
   mv $HOME/.vim $HOME/.vim.old
fi
ln -sf $HOME/.dotfiles/vim $HOME/.vim

if [ -e $HOME/.zshrc ] && [ ! -L $HOME/.zshrc ]
then
   mv $HOME/.zshrc $HOME/.zshrc.old
fi
ln -sf $HOME/.dotfiles/zshrc $HOME/.zshrc

if [ -e $HOME/.gitconfig ] && [ ! -L $HOME/.gitconfig ]
then
   mv $HOME/.gitconfig $HOME/.gitconfig.old
fi
ln -sf $HOME/.dotfiles/gitconfig $HOME/.gitconfig

if [ -e $HOME/.Xresources ] && [ ! -L $HOME/.Xresources ]
then
   mv $HOME/.Xresources $HOME/.Xresources.old
fi
ln -sf $HOME/.dotfiles/Xresources $HOME/.Xresources

if [ -d $HOME/.oh-my-zsh ]
then
   if [ ! -L $HOME/.oh-my-zsh/themes/mine.zsh-theme ]
   then
      mv $HOME/.oh-my-zsh/themes/mine.zsh-theme $HOME/.oh-my-zsh/themes/mine.zsh-theme.old
   fi
   ln -sf $HOME/.dotfiles/mine.zsh-theme $HOME/.oh-my-zsh/themes/mine.zsh-theme
else
   echo "Could not install mine.zsh-theme. Try installing oh-my-zsh if it isn't already installed."
fi
echo "If this is an Arch box running OpenBox and Xfce4, install xinitrc yourself."
