## XDG Base Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_STATE_HOME="$HOME/.local/state"

## Programs
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSHISTFILE=-
export EDITOR="vim"
export VISUAL="vim"

## WSL
# export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
# export LIBGL_ALWAYS_INDIRECT=1

## PATH
export PATH=$PATH:~/.local/bin

## Load .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc
