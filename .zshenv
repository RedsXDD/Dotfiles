# Clean $HOME:
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
[ ! -d "$ZDOTDIR" ] && \mkdir -p "$ZDOTDIR"
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile"
