# vim:fileencoding=utf-8:foldmethod=marker:foldenable

# -------------------------------------- #

# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

# -------------------------------------- #

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Source main shell configs:
files="$(find "${XDG_CONFIG_HOME:-$HOME/.config}/shell/core" -follow -type f -printf '; source %p')"; eval "source ${files##; source}"; unset files

#: Options {{{
# Enable colors:
autoload -U colors && colors

# Disable Ctrl-s:
stty stop undef

# Useful options (look them up with man zshoptions)
setopt \
	autocd \
	autolist \
	autopushd \
	correct \
	hashlistall \
	extendedglob \
	globcomplete \
	interactivecomments \
	listambiguous \
	menucomplete \
	nomatch \
	notify \
	pushdignoredups \
	completeinword
#: }}}
#: Tab complete menu {{{
# Enable tab complete:
autoload -U compinit
zstyle ':completion:*' menu select

# Include hidden files on completion:
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Auto complete with case insenstivity:
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' gain-privileges 1

# Completion styling:
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Navigate completion menu with vim keys:
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# Fix backspace bug when switching modes:
bindkey -v '^?' backward-delete-char
#: }}}
#: Fix basics keybindings: {{{
# Create a zkbd compatible hash, to add other keys to this hash, see: man 5 terminfo.
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# Shift, Alt, Ctrl and Meta Modifiers:
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# Setup keybindings accordingly:
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

[[ -n "${key[Home]}"      ]] && bindkey -M vicmd -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -M vicmd -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -M vicmd -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -M vicmd -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -M vicmd -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -M vicmd -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -M vicmd -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -M vicmd -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -M vicmd -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -M vicmd -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -M vicmd -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -M vicmd -- "${key[Shift-Tab]}" reverse-menu-complete

[[ -n "${key[Home]}"      ]] && bindkey -M visual -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -M visual -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -M visual -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -M visual -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -M visual -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -M visual -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -M visual -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -M visual -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -M visual -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -M visual -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -M visual -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -M visual -- "${key[Shift-Tab]}" reverse-menu-complete
#: }}}
#: Vi mode {{{
# Enable vi mode:
bindkey -v
export KEYTIMEOUT=1

# Open text editor buffer with Ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
bindkey -M vicmd '^v' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M visual '^[[P' vi-delete

# Vi mode cursor style:
local nrm_mode_cursor='\e[1 q'
local ins_mode_cursor='\e[5 q'
# '\e[1 q' -> bliking block.
# '\e[2 q' -> steady block.
# '\e[3 q' -> blinking underline.
# '\e[4 q' -> steady underline.
# '\e[5 q' -> bliking beam shape.
# '\e[6 q' -> steady beam shape.

# Change cursor shape for different vi modes.
zle-keymap-select(){
	if [ "$KEYMAP" = 'vicmd' ] || [ "$1" = 'block' ]; then echo -ne "$nrm_mode_cursor"; fi
	if [ -z "$KEYMAP" ] || [ "$KEYMAP" = 'main' ] || [ "$KEYMAP" = 'viins' ] || [ "$1" = 'beam' ]; then echo -ne "$ins_mode_cursor"; fi
}
zle -N zle-keymap-select

# Initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
zle-line-init(){ zle -K viins; echo -ne "$ins_mode_cursor"; }
zle -N zle-line-init

echo -ne "$ins_mode_cursor"               # Use custom shapep cursor on startup.
preexec(){ echo -ne "$ins_mode_cursor"; } # Use custom shapep cursor for each new prompt.
#: }}}
#: Plugins {{{
#: Plugin manager {{{
# Add plugin function:
zsh_add_plugin(){
	# Base variables:
	local PLUGIN_NAME="$(echo "$1" | cut -d '/' -f 2)"
	local PLUGIN_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/plugins/${PLUGIN_NAME}"

	zsh_load_plugin(){
		[ -f "${PLUGIN_DIR}/${PLUGIN_NAME}.zsh" ] && source "${PLUGIN_DIR}/${PLUGIN_NAME}.zsh"
		[ -f "${PLUGIN_DIR}/${PLUGIN_NAME}.plugin.zsh" ] && source "${PLUGIN_DIR}/${PLUGIN_NAME}.plugin.zsh"
	}

	# Load plugin if it's installed:
	[ -d "$PLUGIN_DIR" ] && zsh_load_plugin && return 0

	# Download and load plugin if it's not installed:
	[ ! -d "$PLUGIN_DIR" ] &&
		local PLUGIN="$1" &&
		\mkdir -vp "$PLUGIN_DIR" &&
		git clone "https://github.com/${PLUGIN}.git" "${PLUGIN_DIR}" &&
		zsh_load_plugin
}
#: }}}
# For more plugins check https://github.com/unixorn/awesome-zsh-plugins
zsh_add_plugin zsh-users/zsh-autosuggestions
zsh_add_plugin zsh-users/zsh-syntax-highlighting
zsh_add_plugin zsh-users/zsh-completions
zsh_add_plugin MichaelAquilina/zsh-you-should-use
zsh_add_plugin zsh-users/zsh-history-substring-search

# Unset functions from plugin manager:
unset -f zsh_add_plugin zsh_load_plugin
#: }}}
#: History {{{
setopt \
	incappendhistory \
	histignoredups \
	appendhistory \
	sharehistory \
	histignorespace \
	histignorealldups \
	histsavenodups \
	histfindnodups

# Default zsh history search:
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Zsh history substring search:
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=black,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=''
HISTORY_SUBSTRING_SEARCH_FUZZY='1'
HISTORY_SUBSTRING_SEARCH_PREFIXED=''
#: }}}

# Shell integrations (Must be after compinit is called):
eval "$(zoxide init --cmd cd zsh)"

#: Shell prompt {{{
# Function to set the PS1 prompt:
set_ps1(){
	export PROMPT='%B%F{blue}%n %f%b'
	export PROMPT="${PROMPT}%B%F{white}at %f%b"
	export PROMPT="${PROMPT}%B%F{cyan}%M %f%b"
	export PROMPT="${PROMPT}%B%F{white}on %f%b"
	export PROMPT="${PROMPT}%B%F{magenta}%D{%r - %d/%m/%Y} %f%b"
	export PROMPT="${PROMPT}%B%F{white}using %f%b"
	export PROMPT="${PROMPT}%B%F{green}zsh%f%b"
	export PROMPT="${PROMPT}%B%F"$'\n'"%(?.%F{white}%5~ >.%F{red}%5~ >)%f%b "
}

eval "$(starship init zsh)" || set_ps1
unset -f set_ps1
#: }}}
