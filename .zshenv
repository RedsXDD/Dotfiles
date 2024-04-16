# Clean $HOME:
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
[ ! -d "$ZDOTDIR" ] && \mkdir -p "$ZDOTDIR"

# Source main shell configs:
profile_files="$(find "${XDG_CONFIG_HOME:-$HOME/.config}/shell" -maxdepth 1 -follow -type f -printf '; source %p')"; eval "source ${profile_files##; source}"; unset profile_files
