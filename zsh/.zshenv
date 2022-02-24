if [ "$DESKTOP_SESSION" = "sway" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
