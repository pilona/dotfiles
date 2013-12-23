# stupid VTE library bug
case "$(cat /proc/$PPID/comm)" in
    xterm|xfce4-terminal)
        export TERM=xterm-256color
        ;;
    st)
        export TERM=st-256color
        ;;
esac

if [ $TERM = linux ]; then
    export TMOUT=120
else
    unset TMOUT
fi

# 256-color colourscheme (Solarized or Molokai) mess up terminal; ugly
# colours.
if [ $(tput colors) -ge 256 ]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
export VISUAL=$EDITOR

export WM=dwm
if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox

    # These aliases are meaningless if not running under X11.
    # One can set DISPLAY explicitly and start them from a Linux VT
    # but that'll likely rarely happen, if at all.
    alias FixCtrlCaps='setxkbmap -option ctrl:nocaps'
    alias chromiump='chromium --proxy-server=socks5://localhost:1080'
    alias mupen64plus='mupen64plus --windowed'
    alias xclock='xclock -update 1 -bg palegreen'

    alias Mupdf='DisownBG mupdf'
    DisownBG() {
        "$@" &
        disown
    }

    tabbed() {
        command tabbed "$@" st -w
    }
else
    export BROWSER=links

    alias startx='exec startx'
fi
alias sr='sr -browser="$BROWSER"'

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset


alias DumpID3Tags='id3 -q "title=\"%t\",\nartist=\"%a\",\nalbum=\"%l\",\ntrack=\"%n\",\nyear=\"%y\",\ngenre=\"%g\",\ncomment=\"%c\""'

alias GitPrettyLog='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

alias cscope='EDITOR=$VISUAL cscope'

alias gcc='gcc -std=c99'
alias gdb='gdb -silent -tui'

alias ghci='ghci -v0'
alias gpg='GPG_TTY="$TTY" gpg'
alias gpgp='gpg --list-options show-photos'

alias bc='bc -q -l'

alias df='df -h'
alias du='du -h'

alias pdb='python -m pdb'
alias pudb='python -m pudb'
alias pytrace='python -m trace --ignore-dir=/usr/lib/python3.3 --trace'
alias python='PYTHONSTARTUP=~/.pythonstartup.py python'

alias info='info --vi-keys'

alias pscgroups='ps xawf -eo pid,user,cgroup,args'

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'

alias sshfs='sshfs -o idmap=user -o uid=1000 -o gid=100'

alias tmux='tmux -f <(~/.tmuxrc)'

lll() {
    ls --color=always "$@" | less -R
}

PQESize() {
    pacman -Qie \
      | grep -e ^Name -e Installed\ Size \
      | awk 'BEGIN { ORS=" " }

             $1 == "Name" { print $3 }
             $1 == "Installed" {
                 if ($4 > 1024) {
                     print $4/1024 "MiB" "\n"
                 } else {
                     print $4 $5 "\n"
                 }
             }' \
      | column -t \
      | column -c $COLUMNS \
      | less
}

mail_account() {
    if [ -z "$MAIL_ACCOUNT" ]; then
        local HOUR=`date +%H`
        local DAY=`date +%u`
        if [ $HOUR -ge 8 ] && [ $HOUR -lt 18 ] && [ $DAY -le 5 ]
        then
            echo cmail.carleton.ca
        else
            echo alexpilon.ca
        fi
    else
        echo "$MAIL_ACCOUNT"
    fi
}
alias mutt='MAIL_ACCOUNT=${MAIL_ACCOUNT:-`mail_account`} mutt'

mbsync() {
    if [ $# = 0 ]; then
        local MAIL_ACCOUNT=$(mail_account)
        if [ -n "$MAIL_ACCOUNT" ] && [ -d "$HOME/Documents/Mail/$MAIL_ACCOUNT" ]; then
            command mbsync "$MAIL_ACCOUNT"
        else
            echo "Cannot sync '$MAIL_ACCOUNT': No such file or directory" 2>&1
            return 1
        fi
    else
        command mbsync "$@"
    fi
}

rc() {
    if [ $# -eq 0 ]; then
        echo 'zsh: rc(): USAGE: rc <list>|<reload>|<start|stop|enable|disable <service(s)>>' 1>&2
        return 1
    else
        case "$1" in
            list)
                shift
                systemctl list-units "$@"
                ;;
            reload)
                systemctl --system daemon-reload
                ;;
            restart)
                shift
                rc stop "$@"
                rc start "$@"
                ;;
            start|stop|enable|disable|status)
                if [ $# -le 1 ]; then
                    echo "zsh: rc(): ERROR: '$1' requires 1 or more arguments of type service name without '.service' suffix." 1>&2
                    return 1
                else
                    action=$1
                    shift
                    for arg in "$@"; do
                        $([ $1 = status ] || echo sudo) systemctl $action "$arg.service"
                    done
                fi
                ;;
            *)
                echo "zsh: rc(): Unknown action '$1'. Action must be one of start, stop, or list." 1>&2
                return 2
                ;;
        esac
    fi
}

SafeLDD() {
    objdump -p "$@" | grep NEEDED | awk '{print $2}'
}


ExtractSrc() {
    grep -h -o -e 'src="[^"]*' -e "src='[^']*" "$@" | cut -b 6-
}

WWWExtractSrc() {
    # Expects only well-formed href attributes.
    if [ "$#" = 0 ]; then
        echo 'ExtractHref: ERROR: Expected URL argument.' 1>&2
    else
        for i in "$@"; do
            curl -L "$i"
        done | ExtractSrc
    fi
}

ExtractHref() {
    # `-i` option to grep necessary because whoever generated the java
    # documentation can't generate proper XHTML. Tags must be lower space.
    # Yeeeesh!
    grep -h -i -o -e 'href="[^"]*' -e "href='[^']*" "$@" | cut -b 7-
}

WWWExtractHref() {
    # Expects only well-formed href attributes.
    if [ "$#" = 0 ]; then
        echo 'ExtractHref: ERROR: Expected URL argument.' 1>&2
    else
        for i in "$@"; do
            curl -L "$i"
        done | ExtractHref
    fi
}

ModPaths() {
    lsmod \
      | sed 1d \
      | awk '{print $1}' \
      | xargs -L 1 modinfo \
      | grep ^filename: \
      | cut -d / -f 6- \
      | sort \
      | cut -d . -f 1
}

FilterShellComment() {
    grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$'
}

FindDupes() {
    if [ $# = 0 ]; then
        md5sum * 2>/dev/null
    else
        md5sum "$@"
    fi \
      | sort \
      | awk '{
                  if (NR > 1 && hash==$1) {
                      if (!system("test \"" $2 "\" -nt \"" file "\""))
                          print $2
                      else
                          print file
                  }
                  hash=$1
                  last=$2
             }'
}

DelDupes() {
    FindDupes | xargs rm
}

UnicodeLookup() {
    [ -n "$BROWSER" ] && "$BROWSER" "http://unicode.org/cldr/utility/character.jsp?a=$1"
}

hexlify() {
    if [ $# != 1 ]; then
        echo "usage: $0 <string>" 1>&2
        return 1
    else
        python -c "from binascii import hexlify; print(hexlify('"$1"'.encode()).decode())"
    fi
}

set bell-style visual

if echo $0 | grep zsh >/dev/null; then
    unset MAILCHECK

    setopt beep notify
    unsetopt autocd
    # Because zsh has a decent vi line editing mode, unlike bash
    bindkey -v # set -o vi

    # Disable beep
    setterm -blength 0

    autoload -U bashcompinit && bashcompinit
    autoload -U compinit && compinit

    autoload -U colors && colors
    PROMPT="[%{$fg[cyan]%}%n%{$fg[blue]%}@%{$fg[green]%}%m %{$fg[red]%}%1~%{$reset_color%}]%# "
    RPROMPT="%{$reset_color%}[%{$fg[yellow]%}\$?=%?%{$reset_color%}]"
    # 2-level prompt
    #PROMPT="┌─[%{$fg[cyan]%}%n%{$reset_color%}][%{$fg[red]%}%1~%{$reset_color%}][%?]
    #└→ "
elif [ $0 = bash ]; then
    PS1="\[$txtwht\][\[$txtcyn\]\u\[$txtblu\]@\[$txtgrn\]\h \[$txtred\]\W\[$txtwht\]]\$ "
    #PS1='[\['${txtcyn}'\]\u\['${txtblu}'\]@\['${txtgrn}'\]\h \['${txtred}'\]\W\['${txtrst}'\]]\$ '

    set -o vi
fi
