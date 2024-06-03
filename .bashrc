# vim:fileencoding=utf-8:foldmethod=marker:foldenable

# ---------------------------------------------- #

# ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
# ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
# ██████╔╝███████║███████╗███████║██████╔╝██║
# ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║
# ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
# ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

# ---------------------------------------------- #

# shellcheck source=/dev/null
# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Run ble.sh if installed (check: https://github.com/akinomyoga/ble.sh)
BLESH_FILE='/usr/share/blesh/ble.sh'
[ -f "$BLESH_FILE" ] && source "$BLESH_FILE"

# Source main shell configs:
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
files="$(find "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions" -follow -type f -printf '; source %p')"; eval "source ${files##; source}"; unset files

#: Options {{{
# ^C no longer shows on C-c keypress:
bind "set echo-control-characters off"

shopt -s autocd         # Change to named directory.
shopt -s cdspell        # Autocorrects cd misspellings.
shopt -s dirspell       # Autocorrects dir misspellings.
shopt -s dotglob        # Inclued filenames beginning with a ‘.’ in the results of pathname expansion.
shopt -s expand_aliases # Expand aliases.
shopt -s checkwinsize   # Checks term size when bash regains control.
stty -ixon              # Disable Ctrl-s and Ctrl-q.
#: }}}
#: Vi mode {{{
# Enable vi mode:
set -o vi

# Clear screen on vi mode with C-l.
bind -m vi-command '"\C-l":clear-screen'; bind -m vi-insert '"\C-l":clear-screen'

# Vi mode cursor style:
nrm_mode_cursor='\1\e[1 q\2'
ins_mode_cursor='\1\e[5 q\2'
# '\e[1 q' -> bliking block.
# '\e[2 q' -> steady block.
# '\e[3 q' -> blinking underline.
# '\e[4 q' -> steady underline.
# '\e[5 q' -> bliking beam shape.
# '\e[6 q' -> steady beam shape.

# (Vi mode) Change cursor shape to a block when in normal mode:
bind "set show-mode-in-prompt on"
bind "set vi-cmd-mode-string $nrm_mode_cursor"
bind "set vi-ins-mode-string $ins_mode_cursor"
unset nrm_mode_cursor ins_mode_cursor
#: }}}
#: Tab complete options {{{
bind 'TAB:menu-complete'                # Tab menu.
bind "set colored-stats on"             # Color on tab completion for files and dirs.
bind "set colored-completion-prefix on" # Color on tab completion matches.
bind "set show-all-if-ambiguous on"     # Hit tab once to complete.
bind "set completion-map-case on"       # Treats hyphens and underscores as equivalent when performing case-insensitive filename matching and completion.
bind "set completion-ignore-case on"    # Ignore upper and lowercase with TAB completion.
bind "set completion-display-width 0"   # number of screen columns used to display possible matches when performing completion.
bind "set completion-query-items 1000"  # Amount of completions that can be displayed.

setup_fzf_tab_completion(){
	local PLUGIN_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/bash/plugins"
	[ ! -d "$PLUGIN_DIR" ] && mkdir -vp "$PLUGIN_DIR"

	local FZF_TAB_PLUGIN_DIR="${PLUGIN_DIR}/fzf-tab-completion"
	[ ! -d "${FZF_TAB_PLUGIN_DIR}" ] && git clone https://github.com/lincheney/fzf-tab-completion "${FZF_TAB_PLUGIN_DIR}"
	[ -f "${FZF_TAB_PLUGIN_DIR}/bash/fzf-bash-completion.sh" ] && source "${FZF_TAB_PLUGIN_DIR}/bash/fzf-bash-completion.sh"
	bind -x '"\t": fzf_bash_completion'

	unset -f setup_fzf_tab_completion
}
setup_fzf_tab_completion

# Add scripts to the list of valid fzf-tab commands.
complete -o bashdefault -o default -F _fzf_path_completion l.
complete -o bashdefault -o default -F _fzf_path_completion v
complete -o bashdefault -o default -F _fzf_path_completion sv
complete -o bashdefault -o default -F _fzf_path_completion doasedit
complete -o bashdefault -o default -F _fzf_path_completion lustbg
complete -o bashdefault -o default -F _fzf_path_completion waybg
complete -o bashdefault -o default -F _fzf_path_completion mpv
complete -o bashdefault -o default -F _fzf_path_completion mvi
#: }}}
#: History {{{
shopt -s histappend # Do not overwrite history
shopt -s cmdhist    # Save multi-line commands in history as single line

# Search backwards/forwards in history from letter:
bind -m vi-insert '"\C-p": history-search-backward'
bind -m vi-insert '"\C-n": history-search-forward'
bind -m vi-insert '"\C-k": history-substring-search-backward'
bind -m vi-insert '"\C-j": history-substring-search-forward'
#: }}}
#: Shell prompt {{{
# Function to set the PS1 prompt:
set_ps1(){
	# Color variables:
	local black=''
	local red=''
	local green=''
	local yellow=''
	local blue=''
	local magenta=''
	local cyan=''
	local white=''
	local bold=''
	local reset=''

	# \[ and \] are required to define the cursor position
	black="\[$(tput setaf 0)\]"
	red="\[$(tput setaf 1)\]"
	green="\[$(tput setaf 2)\]"
	yellow="\[$(tput setaf 3)\]"
	blue="\[$(tput setaf 4)\]"
	magenta="\[$(tput setaf 5)\]"
	cyan="\[$(tput setaf 6)\]"
	white="\[$(tput setaf 7)\]"
	bold="\[$(tput bold)\]"
	reset="\[$(tput sgr0)\]"

	# Prompt:
	export PROMPT_DIRTRIM='5' # Depth of "current directory" when using \w or \W
	export PS1=''
	export PS1+="${bold}${blue}\u ${reset}"
	export PS1+="${bold}${white}at ${reset}"
	export PS1+="${bold}${cyan}\H ${reset}"
	export PS1+="${bold}${white}on ${reset}"
	export PS1+="${bold}${magenta}\D{%r - %d/%m/%Y} ${reset}"
	export PS1+="${bold}${white}using ${reset}"
	export PS1+="${bold}${green}bash${reset}"
	export PS1+="\n${bold}\`[ \$? = 0 ] && echo \"${white}\w >\" || echo \"${red}\w >\"\`${reset} "
}

eval "$(starship init bash)" || set_ps1
unset -f set_ps1
#: }}}

# Shell integrations:
eval "$(fzf --bash)"
eval "$(zoxide init --cmd cd bash)"

# Run fastfetch:
fastfetch
