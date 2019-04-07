#!/bin/bash
while [ "$select" != "Cancel" -a "$select" != "Suspend" -a "$select" != "Hibernate"  -a "$select" != "Logout"  -a "$select" != "Reboot"  -a "$select" != "Shutdown"  ]; do
    select=$(echo -e 'Suspend\nHibernate\nLogout\nReboot\nShutdown\nCancel' | dmenu -y 340 -w 1000 -x 460 -h 35 -nb '#000022' -nf '#16A085' -sb '#881133' -sf '#101011' -fn 'Bitstream Vera Sans Bold-16' -i -p "Leave") 
    [ -z "$select" ] && exit 0
done
[ "$select" = "Cancel" ] && exit 0
[ "$select" = "Suspend" ] && i3exit suspend
[ "$select" = "Hibernate" ] && i3exit hibernate
[ "$select" = "Logout" ] && i3exit logout
[ "$select" = "Reboot" ] && i3exit reboot
[ "$select" = "Shutdown" ] && i3exit shutdown
exit 0