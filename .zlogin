export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$PATH:/opt/x-tools/bin"

export MANPATH="$HOME/.cabal/share/man:$MANPATH"
export MANPATH="$HOME/.local/share/man:$MANPATH"

export LESS='FRXS'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export SDL_VIDEO_FULLSCREEN_HEAD=0

export WM=dwm
if [ $(tty) = /dev/tty1 ]; then
    exec startx
fi
