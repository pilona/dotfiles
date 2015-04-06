case "$(cat /proc/$PPID/comm)" in
    # stupid VTE library bug
    xterm|xfce4-terminal)
        export TERM=xterm-256color
        ;;
    tmux)
        # Yes, we want to save to a file, and risk being out of date, whereas
        # just using :Tmuxline means that we see, however short, the old tmux
        # status bar.
        if ! [ -f ~/.tmuxline.conf ]; then
            vim +'Tmuxline jellybeans' \
                +'TmuxlineSnapshot ~/.tmuxline.conf' \
                +qall 2>/dev/null
        fi
        ;;
esac

if [ $TERM = linux ]; then
    export TMOUT=120

    # Disable beep
    setterm -blength 0
else
    unset TMOUT
fi

# 256-color colourscheme (Solarized or Molokai) mess up terminal; ugly
# colours.
if [ "$(tput colors)" -ge 256 ]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
export VISUAL=$EDITOR

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
    export QT_STYLE_OVERRIDE=gtk

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

    ClearClipboard() {
        for selection in clipboard primary secondary; do
            xclip -selection $selection < /dev/null
        done
        killall xclip
    }
else
    export BROWSER=links

    alias startx='exec startx'
fi
alias sr='sr -browser="$BROWSER"'

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

alias cscope='EDITOR=$VISUAL cscope'

alias gcc='gcc -fdiagnostics-color=auto -std=gnu11'
alias gdb='gdb -silent'

alias ghci='ghci -v0'
alias gpg='GPG_TTY="$TTY" gpg'
alias gpgp='gpg --list-options show-photos'

alias bc='bc -q -l'

alias df='df -h'
alias du='du -h'

alias pdb='python -m pdb'
alias pytrace='python -m trace --ignore-dir=/usr/lib/python3.* --trace'
Python() (
    export PYTHONPATH="${HOME}/.python.d:${PYTHONPATH}"
    export PYTHONSTARTUP="${HOME}/.python.d/rc.py"
    if [ $# -gt 0 ]; then
        pdb "$@"
    else
        command python -q
    fi
)

alias info='info --vi-keys'

alias pscgroups='ps xawf -eo pid,user,cgroup,args'

alias c='cd'
alias c..='cd ..'
alias c...='cd ../..'
alias c....='cd ../../..'
alias c.....='cd ../../../..'
alias c......='cd ../../../../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd......='cd ../../../../..'
alias lcd='cd'
alias d='cd'
alias t='cat'

alias sshfs='sshfs -o idmap=user -o uid=1000 -o gid=100'

alias tmux='tmux -f <(~/.tmuxrc)'

alias win32='WINEARCH=win32 WINEPREFIX=~/.wine'

alias Startpage='$BROWSER "https://startpage.com/do/mypage.pl?prf=42d1c9d47b691682365d62362ea73b49"'

alias steam='STEAM_FRAME_FORCE_CLOSE=1 steam'

alias xterm='xterm -rv -cr red'
alias uxterm='uxterm -rv -cr red'
alias emacs='emacs -nw'
alias mplayer='mplayer -msglevel all=2'
alias vlc='vlc --qt-minimal-view'
alias clisp='clisp --quiet'
alias javadebug='java -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=y'

alias ping='ping -OD'
alias ping6='ping6 -OD'

alias ipa='ip address show scope global up'
alias ip4='ip -4 address show scope global up'
alias ip6='ip -6 address show scope global up'
alias ipr='ip -4 route show scope global'

alias l='ls -C'
alias lt='ls -t'
alias lx='ls -X'
alias la='ls -A'
alias ll='ls -l'
alias lg='ls --group-directories-first'
alias lD='ls -d'
alias lu='ls -U'
ls() {
    command ls --human-readable \
               --escape \
               --width=$COLUMNS \
               -C \
               --color=always "$@" | less
}

alias n='newsbeuter -q'

alias grep='grep -E --color=auto'

alias MountFat='sudo mount -o uid=$(id -u),gid=$(id -g),fmask=7177,dmask=7077'

if command -v bsdcpio >/dev/null 2>&1 && \
   ! command -v cpio  >/dev/null 2>&1; then
    alias cpio=bsdcpio
fi

PQE() {
    pacman -Qe | cut -d ' ' -f 1 | column -c $COLUMNS | less
}

PQESize() {
    pacman -Qie \
      | awk 'BEGIN {
                 ORS=" "
                 OFMT="%.2f"
             }

             $1 == "Name" { print $3 }
             $1 " " $2 == "Installed Size" {
                 if ($4 > 1024) {
                     printf OFMT " %s\n", $4/1024, "MiB"
                 } else {
                     printf OFMT " %s\n", $4, $5
                 }
             }' \
      | column -t \
      | column -c $COLUMNS \
      | less
}

PQESize2() {
    pacman -Qie \
      | awk 'BEGIN { ORS = " " }

             $1 == "Name" { print $3 }

             $1 " " $2 == "Installed Size" {
                 size = $(NF-1)
                 size *= 1024
                 print size "\n"
             }' \
      | sort -rnk 2 \
      | awk 'BEGIN {
                 suffix[0] = "B"
                 suffix[1] = "KiB"
                 suffix[2] = "MiB"
                 suffix[3] = "GiB"
             }
             $0 !~ /^[[:space:]]*$/ {
                 name = $1
                 size = $2
                 oom  = 0
                 while (size > 1024) {
                     size /= 1024
                     oom++
                 }
                 printf "%s %.2f %s\n", name, size, suffix[oom]
             }' \
      | column -t \
      | column -c $COLUMNS \
      | less
}

mail_account() {
    if [ -z "$M" ]; then
        local HOUR=`date +%H`
        local DAY=`date +%u`
        if [ $HOUR -ge 8 ] && [ $HOUR -lt 18 ] && [ $DAY -le 5 ]
        then
            echo cmail.carleton.ca
        else
            echo alexpilon.ca
        fi
    else
        echo "$M"
    fi
}
alias mutt='MAIL_ACCOUNT=$(mail_account) mutt'

mbsync() {
    if [ $# = 0 ]; then
        local MAIL_ACCOUNT=$(mail_account)
        if [ -n "$MAIL_ACCOUNT" ] && [ -d "$HOME/Documents/Mail/$MAIL_ACCOUNT" ]; then
            command mbsync "$MAIL_ACCOUNT"
        else
            echo "Cannot sync '$MAIL_ACCOUNT': No such file or directory" 1>&2
            return 1
        fi
    else
        command mbsync "$@"
    fi
}

rc() {
    if [ $# = 0 ]; then
        action=list-units
    else
        action="$1"
        shift
    fi
    case "$action" in
        l|lu) action=list-units ;;
        ls) action=list-sockets ;;
    esac
    case "$action" in
        list*|status|show|-*)
            systemctl "$action" "$@"
            ;;
        log)
            if ! [ $# = 1 ]; then
                echo "Only 1 argument supported to 'log' for now." 1>&2
                return 1
            else
                sudo journalctl -u "$1"
            fi
            ;;
        *)
            sudo systemctl "$action" "$@"
            ;;
    esac
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
      | xargs -L 1 modinfo -F filename \
      | cut -d / -f 6- \
      | sort \
      | cut -d . -f 1
}

FilterShellComment() {
    grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$@"
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

_webdoc() {
    docs="$1"
    shift
    prefix="$2"
    shift

    for arg in "$@"; do
        local target
        target="${docs}/${arg}.html"
        if ! [ -f  "$target" ]; then
            echo "${prefix}: No such file or directory: \"$target\"" 1>&2
            return 1
        fi
    done

    while [ $# -gt 0 ]; do
        "$BROWSER" "file://${docs}/${1}.html"
        shift
        while [ -z "$response" ] && [ $# -gt 0 ]; do
            # Emulate man
            echo "--${prefix}-- next: $1 [ view (return) | skip (Ctrl-D) | quit (Ctrl-C) ]"
            local response
            if ! read response; then
                shift
            else
                break
            fi
        done
    done
}

# TODO: Handle member references in first argument.
# TODO: Handle builtins: constants, functions, classes, etc.
Pydoc() {
    local basedir='/usr/share/doc/python/html'
    if [ $# = 0 ]; then
        "$BROWSER" "${basedir}/index.html"
    else
        _webdoc "${basedir}/library" Pydoc "$@"
    fi
}

# TODO: Catch member references in first argument and jump to first instance if
#       type not specified.
Javadoc() {
    _webdoc /usr/share/doc/java8-openjdk/api \
            Javadoc \
            $(for arg in "$@"; do
                  if command grep -qF . <<< "$arg"; then
                      echo "$(tr . / <<< "$arg")"
                  else
                      echo "java/lang/${arg}"
                  fi
              done)
}

ImageSize() {
    if [ $# = 0 ]; then
        echo /dev/stdin
    else
        for pic in "$@"; do
            echo "$pic"
        done
    fi \
      | while read line; do
            identify "$line" \
              | cut -c $(($(expr length "$line") + 1))-
        done 2>/dev/null \
      | awk '{ print $2 }'
}

UT2004() {
    pushd .
    cd /opt/ut2004/System
    xinit ./ut2004-bin-linux-amd64 -- :${1:-0}
    popd .
}

Termium() {
    local _lang
    local _base
    _lang=eng
    _base="http://www.btb.termiumplus.gc.ca/tpv2alpha/alpha-eng.html?lang=${_lang}"
    if [ $# = 0 ]; then
        "$BROWSER"  "$_base"
    else
        "$BROWSER" "${_base}&i=&index=alt&__index=alt&srchtxt=$(python -c "import urllib.request; print(urllib.request.quote(\"$*\"))")&comencsrch.x=0&comencsrch.y=0"
    fi
}

OPL() {
    # TODO: Support other search forms
    local _base
    local _type
    local _query
    local _locale
    _base=http://ottawa.bibliocommons.com/search
    _type=keyword
    _locale=en_CA
    _query="$(python -c 'from sys import argv; print("+".join(argv[1:]))' "$@")"
    "$BROWSER" "${_base}?locale=${_locale}&t=${_type}&q=${_query}"
}

Github() {
    local _base
    local _user
    local _repo

    _base="https://github.com"
    _user="${${1%%/*}:-pilona}"
    if grep -qF / <<< "$1"; then
        _repo="${1##*/}"
    else
        _repo=
    fi

    "$BROWSER" "${_base}/${_user}/${_repo}"
}

LinuxGitMsg() {
    local _base
    local _qs

    _base="http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/"
    _qs="$(python -c "from urllib.parse import urlencode; print(urlencode({'qt': 'grep', 'q': '$*'}))")"

    "$BROWSER" "${_base}?${_qs}"
}

StableQueue() {
    "$BROWSER" 'http://git.kernel.org/cgit/linux/kernel/git/stable/stable-queue.git/tree/'
}

Quote() {
    python -c "from urllib.parse import quote; print(quote('$*'))"
}

UnQuote() {
    python -c "from urllib.parse import unquote; print(unquote('$*'))"
}

Weather() {
    "$BROWSER" "http://weather.gc.ca/city/pages/on-118_metric_e.html"
}

Canal() {
    "$BROWSER" "http://www.ncc-ccn.gc.ca/rideau-canal-skateway/"
}

Wiktionary() {
    # TODO: percent-encode
    "$BROWSER" "http://en.wiktionary.org/wiki/$1"
}

NmapSSL() {
    nmap --script ssl-enum-ciphers -p "$@"
}

ReallyMute() {
    for control in Master Headphone Speaker Bass\ Speaker PCM; do
        [ "$control" = PCM ] || amixer --quiet set "$control" mute
        amixer --quiet set "$control" 0
    done
}

PDFCat() {
    local output="$1"
    shift
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="$output" "$@"
}

NoFox() {
    for comm in firefox chromium; do
        killall --quiet --process-group -STOP $comm
    done 2>&1
}

MXToolBox() {
    if [ $# = 1 ]; then
        "$BROWSER" "http://mxtoolbox.com/domain/$1/?source=findmonitors"
    else
        echo 'usage: MXToolBox <domain>' 1>&2
    fi
}

Binaries() {
    pacman -Ql "$@" \
      | grep bin/ \
      | awk -F / '{print $NF}' \
      | column -c $COLUMNS
}

Manpages() {
    pacman -Ql "$@" \
      | grep man/ \
      | awk -F / '{print $NF}' \
      | column -c $COLUMNS
}

faketty() {
    script --quiet --command "$*" /dev/null
}

Duration() {
    mediainfo ${*:-*} \
      | awk 'BEGIN {
                 total=0
             }
             $0 ~ /Duration / && NR % 3 == 1 {
                 total += $3 * 60 + $4
             }
             END {
                if (total >= 3600)
                    printf "%dh %dmn %ds", total/3600, total/60, total%60
                else
                    printf "%dmn %ds", total/60, total%60
             }'
}

alias sudo='sudo '  # Dirty trick to force alias expansion in sudo

set -o vi

unset MAILCHECK
unset HISTFILE
HISTSIZE=4096

case "$(cat /proc/$$/comm)" in
    zsh)
        setopt beep notify
        unsetopt autocd
        set bell-style visual

        # Disable beep
        #setterm -blength 0

        autoload -U bashcompinit && bashcompinit
        autoload -U compinit && compinit

        KEYTIMEOUT=1
        bindkey '^R' history-incremental-search-backward
        ;;
    bash)
        set +o histexpand

        complete -cf sudo

        bind 'set show-all-if-ambiguous on'
        bind 'set menu-complete-display-prefix on'
        bind 'TAB:menu-complete'
        ;;
esac

# TODO: Figure out how to query if terminal supports UTF-8
if [ "$TERM" = linux ] || [ "$(tput colors)" -lt 256 ]; then
    case "$(cat /proc/$$/comm)" in
        zsh)
            autoload -U colors && colors
            PROMPT="[%{$fg[cyan]%}%n%{$fg[blue]%}@%{$fg[green]%}%m %{$fg[red]%}%1~%{$reset_color%}]%# "
            RPROMPT="%{$reset_color%}[%{$fg[yellow]%}\$?=%?%{$reset_color%}]"
            # 2-level prompt
            #PROMPT="┌─[%{$fg[cyan]%}%n%{$reset_color%}][%{$fg[red]%}%1~%{$reset_color%}][%?]
            #└→ "
            ;;
        bash)
            PS1="\[$txtrst\][\[$txtcyn\]\u\[$txtblu\]@\[$txtgrn\]\h \[$txtred\]\W\[$txtrst\]]\$ "
            ;;
    esac
else
    # TODO: Only do this if 256-colour and UTF-8 support present in terminal,
    #       not necessarily because in a Linux console.
    if ! [ -f ~/.promptline.sh ]; then
        vim +':PromptlineSnapshot ~/.promptline.sh airline' +qall
    fi

    if [ "$(cat /proc/$$/comm)" = "zsh" ]; then
        # TODO: Make more concise.
        #       See http://stackoverflow.com/questions/3622943/zsh-vi-mode-status-line.
        vim_ins_mode="INSERT"
        vim_cmd_mode="NORMAL"
        vim_mode=$vim_ins_mode

        zle-keymap-select() {
            vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
            __promptline
            zle reset-prompt
        }
        zle -N zle-keymap-select

        zle-line-finish() {
            vim_mode=$vim_ins_mode
        }
        zle -N zle-line-finish

        TRAPINT() {
            vim_mode=$vim_ins_mode
            return $((128 + $1))
        }
    fi

    . ~/.promptline.sh
fi
