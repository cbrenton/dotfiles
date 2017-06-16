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
if [ ! -L $HOME/.vim ]
then
   ln -sf $HOME/.dotfiles/vim $HOME/.vim
fi

if [ ! -L $HOME/.tmux ]
then
   ln -sf $HOME/.dotfiles/tmux $HOME/.tmux
fi

if [ -e $HOME/.zshrc ] && [ ! -L $HOME/.zshrc ]
then
   mv $HOME/.zshrc $HOME/.zshrc.old
fi
ln -sf $HOME/.dotfiles/zshrc $HOME/.zshrc

if [ -e $HOME/.aliases ] && [ ! -L $HOME/.aliases ]
then
   mv $HOME/.aliases $HOME/.aliases.old
fi
ln -sf $HOME/.dotfiles/aliases $HOME/.aliases

if [ -e $HOME/.tmux.conf ] && [ ! -L $HOME/.tmux.conf ]
then
   mv $HOME/.tmux.conf $HOME/.tmux.conf.old
fi
ln -sf $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf

if [ -e $HOME/.gitconfig ] && [ ! -L $HOME/.gitconfig ]
then
   mv $HOME/.gitconfig $HOME/.gitconfig.old
fi
ln -sf $HOME/.dotfiles/gitconfig $HOME/.gitconfig

if [ -e $HOME/.Xmodmap ] && [ ! -L $HOME/.Xmodmap ]
then
   mv $HOME/.Xmodmap $HOME/.Xmodmap.old
fi
ln -sf $HOME/.dotfiles/xmodmap $HOME/.xmodmap

if [ -e $HOME/.Xresources ] && [ ! -L $HOME/.Xresources ]
then
   mv $HOME/.Xresources $HOME/.Xresources.old
fi
ln -sf $HOME/.dotfiles/Xresources $HOME/.Xresources
xrdb $HOME/.Xresources

ln -sf $HOME/.dotfiles/monokai.itermcolors $HOME/monokai.itermcolors

FOUND=false
omzDirs=( ".oh-my-zsh" ".omz" )
for OMZ in "${omzDirs[@]}"
do
   if [ -d $HOME/$OMZ ]
   then
      FOUND=true
      if [ -e $HOME/$OMZ/themes/cbr.zsh-theme ] && [ ! -L $HOME/$OMZ/themes/cbr.zsh-theme ]
      then
         mv $HOME/$OMZ/themes/cbr.zsh-theme.old
      fi
      ln -sf $HOME/.dotfiles/cbr.zsh-theme $HOME/$OMZ/themes/cbr.zsh-theme
      break
   fi
done
if [ ! $FOUND ]
then
   echo "Could not install cbr.zsh-theme. Try installing oh-my-zsh if it isn't already installed."
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ret

echo "If this is an Arch box running OpenBox and Xfce4, install xinitrc yourself."
