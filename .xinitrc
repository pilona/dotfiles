#! /bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*.sh; do
        . "$f"
    done
fi

. ~/.xprofile

exec "$WM"
