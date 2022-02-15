# Should be called before compinit
zmodload zsh/complist

# FZF
# TODO update for mac
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt INTERACTIVE_COMMENTS # Set comments in interactive shell.
unsetopt BEEP               # Beeping is ANNOYING!
unsetopt NOMATCH            # No annoying youtube-dl errors again.

zle_highlight=('paste:none')

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use ranger to switch directories and bind it to ctrl-o

rangercd () {
    echo
    ranger --choosedir=$XDG_CACHE_HOME/.rangerdir < $TTY
    LASTDIR="$(< $XDG_CACHE_HOME/.rangerdir)"
    cd "$LASTDIR"
}

bindkey -s '^o' 'rangercd\n'
bindkey -s '^a' 'bc -lq\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

## Functions

function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    # pretty output
    local c_reset="\033[0m" c_red="\033[1;31m" c_green="\033[1;32m"

    local PLUGIN_NAME="${1##*\/}"
    local PLUGIN_DIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins/$PLUGIN_NAME"

    if [ ! -d "$PLUGIN_DIR" ]; then
        # clone plugin if it does not exists in $PLUGIN_DIR
        printf "%b==> [zsh-plugin]%b Getting plugin '%s'\n" "$c_green" "$c_reset" "$PLUGIN_NAME"

        git clone --depth 1 --recurse-submodules "https://github.com/${1}.git" "$PLUGIN_DIR" || \
        { printf "%b==> [zsh-plugin]%b Error getting plugin '%s'\n" "$c_red" "$c_reset" "$PLUGIN_NAME"; return 1; }
    fi

    # at this point, $PLUGIN_DIR will exist (except in
    # case of network issue), so source the plugin
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh" || \
    { printf "%b==> [zsh-plugin]%b Error sourcing plugin '%s' from '%s'\n" "$c_red" "$c_reset" "$PLUGIN_NAME" "$PLUGIN_DIR"; return 1; }
}

function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For completions
		completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
		fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
		fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
	completion_file="$(basename "${completion_file_path}")"
	if [ "$2" = true ] && compinit "${completion_file:1}"
}

function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)        tar xjf $1        ;;
            *.tar.gz)         tar xzf $1        ;;
            *.bz2)            bunzip2 $1        ;;
            *.rar)            unrar x $1        ;;
            *.gz)             gunzip $1         ;;
            *.tar)            tar xf $1         ;;
            *.tar.xz)         tar xf $1         ;;
            *.tbz2)           tar xjf $1        ;;
            *.tgz)            tar xzf $1        ;;
            *.zip)            unzip $1          ;;
            *.Z)              uncompress $1     ;;
            *.7z)             7z x $1          ;;
            *)                echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

## Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

# find out which distribution we are running on
_distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# set an icon based on the distro
case $_distro in
    *kali*)                  ICON="ﴣ";;
    *arch*)                  ICON="";;
    *debian*)                ICON="";;
    *raspbian*)              ICON="";;
    *ubuntu*)                ICON="";;
    *elementary*)            ICON="";;
    *fedora*)                ICON="";;
    *coreos*)                ICON="";;
    *gentoo*)                ICON="";;
    *mageia*)                ICON="";;
    *centos*)                ICON="";;
    *opensuse*|*tumbleweed*) ICON="";;
    *sabayon*)               ICON="";;
    *slackware*)             ICON="";;
    *linuxmint*)             ICON="";;
    *alpine*)                ICON="";;
    *aosc*)                  ICON="";;
    *nixos*)                 ICON="";;
    *devuan*)                ICON="";;
    *manjaro*)               ICON="";;
    *rhel*)                  ICON="";;
    *)                       ICON="";;
esac

## Aliases

source $ZDOTDIR/aliases

## NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## Load Starship
export STARSHIP_DISTRO="$ICON "
eval "$(starship init zsh)"

## z
eval "$(zoxide init zsh)"
