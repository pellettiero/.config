# pellettiero's dotfiles - .zprofile

# env
# Standard PATH
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export LANG=it_IT.UTF-8

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export PREFIX=/usr
export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/xorg/xinitrc"
export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus

export TERMINAL='st'
export EDITOR='nvim'
export VISUAL='nvim'

# local bin
export PATH="$HOME/.local/bin:$PATH:bin"

# Pull GTK2 RC files from the standard config location, similar to gtk-3.0
[ -e /etc/gtk-2.0 ] && export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export BSPWM_SOCKET="$XDG_RUNTIME_DIR/bspwm-socket"
export HISTFILE="$XDG_DATA_HOME/zsh/history"

export MANPAGER="less -+X -is"

export LESS="-FiQMXR"
export LESSCHARSET="UTF-8"
export LESSHISTFILE="-"
export LESSOPEN="| pygmentize -O style=native -f console256 -g %s"

export AURDEST="/tmp/makepkg"
export PYTHONOPTIMIZE=2

# Android development
export ANDROID_HOME=$HOME/Documents/android-sdk
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

# Create chrome_cache and qutebrowser_cache in /tmp
[[ ! -d /tmp/chrome_cache/ ]] && mkdir /tmp/chrome_cache
[[ ! -d /tmp/qutebrowser_cache/ ]] && mkdir /tmp/qutebrowser_cache

# Start X automatically
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx "$XINITRC" -- -keeptty -nolisten tcp > /tmp/Xorg-$(date --iso-8601).log 2>&1
