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

# Should be done by LightDM.
if [ -f $HOME/.Xmodmap ]
then
   /usr/bin/xmodmap $HOME/.Xmodmap
elif [ -f $HOME/.xmodmap ]
then
   /usr/bin/xmodmap $HOME/.xmodmap
fi

# Load Xresources.
xrdb -merge ~/.Xresources

case "$1" in
   xmonad)
      # Start the icon tray.
      #trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --alpha 0 --tint 0x000000 --height 17 &
      trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --alpha 0 --tint 0x000000 --height 18 &
      #trayer --SetDockType true --SetPartialStrut true &
      # Set the background.
      if [ -e ~/.fehbg ]
      then
         sh ~/.fehbg
      else
         feh --bg-center /usr/share/backgrounds/astronaut_shark.jpg
      fi
      # Set the cursor.
      xsetroot -cursor_name left_ptr
      # Fire up apps.
      xscreensaver -no-splash &

      if [ -x /usr/bin/nm-applet ]
      then
         nm-applet --sm-disable &
      fi

      export DE=xfce

      # Start xmonad.
      exec ck-launch-session dbus-launch xmonad
      ;;
   xfce)
      # Start xfce.
      exec ck-launch-session dbus-launch startxfce4
      trayer &
      neap &
      ;;
   *)
      ;;
esac

# ...or the Window Manager of your choice
