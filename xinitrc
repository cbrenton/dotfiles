#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ -f $HOME/.Xmodmap ]
then
   /usr/bin/xmodmap $HOME/.Xmodmap
elif [ -f $HOME/.xmodmap ]
then
   /usr/bin/xmodmap $HOME/.xmodmap
fi

# exec gnome-session
# exec startkde
exec ck-launch-session startxfce4
# ...or the Window Manager of your choice
xrdb -merge ~/.Xresources

trayer &

neap &
