## XDG Base Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_STATE_HOME="$HOME/.local/state"

## ZSH config
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

## Programs
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSHISTFILE=-
export ATOM_HOME="$XDG_DATA_HOME"/atom
export BASH_COMPLETION_USER_FILE="$XDG_CACHE_HOME"/bash_completion
export CALCHISTFILE="$XDG_CACHE_HOME"/calc_history
export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg
export GOPATH="$XDG_DATA_HOME"/go
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export IPFS_PATH="$XDG_DATA_HOME"/ipfs
export KDEHOME="$XDG_CONFIG_HOME"/kde
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export _Z_DATA="$XDG_DATA_HOME/z"
export EDITOR="nvim"
export VISUAL="nvim"

## WSL
# export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
# export LIBGL_ALWAYS_INDIRECT=1

## PATH
export PATH=$PATH:~/.local/bin
