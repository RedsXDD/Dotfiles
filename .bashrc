# vim:fileencoding=utf-8:foldmethod=marker

# ---------------------------------------------- #

# ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
# ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
# ██████╔╝███████║███████╗███████║██████╔╝██║
# ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║
# ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
# ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

# ---------------------------------------------- #

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Source main shell configs:
files="$(find "${XDG_CONFIG_HOME:-$HOME/.config}/shell/core" -follow -type f -printf '; source %p')"; eval "source ${files##; source}"; unset files

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

# History:
shopt -s histappend # Do not overwrite history
shopt -s cmdhist    # Save multi-line commands in history as single line
#: }}}
#: Vi mode cursor {{{
# Enable vi mode:
set -o vi

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
bind "set colored-stats On"             # Color on tab completion for files and dirs.
bind "set colored-completion-prefix On" # Color on tab completion matches.
bind "set show-all-if-ambiguous on"     # Hit tab once to complete.
bind "set completion-map-case on"       # Treats hyphens and underscores as equivalent when performing case-insensitive filename matching and completion.
bind "set completion-ignore-case on"    # Ignore upper and lowercase with TAB completion.
bind "set completion-display-width 0"   # number of screen columns used to display possible matches when performing completion.
bind "set completion-query-items 1000"  # Amount of completions that can be displayed.
#: }}}
#: Keybindings {{{
#: History {{{
# Search backwards in history from letter:
bind -m vi-command '"\e[A": history-substring-search-backward'
bind -m vi-insert '"\e[A": history-substring-search-backward'

# Search forwards in history from letter:
bind -m vi-command '"\e[B": history-substring-search-forward'
bind -m vi-insert '"\e[B": history-substring-search-forward'

# Move forwards by word:
bind -m vi-command '"\e[1;5C": forward-word'
bind -m vi-insert '"\e[1;5C": forward-word'

# Move backward by word
bind -m vi-command '"\e[1;5D": backward-word'
bind -m vi-insert '"\e[1;5D": backward-word'
#: }}}
# Vi-command mode bindings:
bind -m vi-command '"\C-l":clear-screen'

# Vi-insert mode bindings:
bind -m vi-insert '"\C-l":clear-screen'
bind -m vi-insert '"\C-f":"fzf-hist\C-m"' # Run fzf-hist.
bind -m vi-insert '"\C-e":"fzf-configs\C-m"' # Edit files with an fzf script.
bind -m vi-insert '"\C-o":"cdi\C-m"' # Open zoxide directory menu.
#: }}}

# Startup zoxide:
eval "$(zoxide init --cmd cd bash)"

#: Shell prompt {{{
# Function to set the PS1 prompt:
set_ps1(){
	# Color variables:
	# \[ and \] are required to define the cursor position
	local black="\[$(tput setaf 0)\]"
	local red="\[$(tput setaf 1)\]"
	local green="\[$(tput setaf 2)\]"
	local yellow="\[$(tput setaf 3)\]"
	local blue="\[$(tput setaf 4)\]"
	local magenta="\[$(tput setaf 5)\]"
	local cyan="\[$(tput setaf 6)\]"
	local white="\[$(tput setaf 7)\]"
	local bold="\[$(tput bold)\]"
	local reset="\[$(tput sgr0)\]"

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
#: Auto completions {{{
# Uncomment any line to enable extra completions.
# WARNING: the more completions are enabled the slower the shell prompt will be!
# eval "$(glow completion bash)"      # Glow
# eval "$(starship completions bash)" # Starship
# eval "$(procs --gen-completion-out bash)" # Procs
# eval "$(zellij setup --generate-completion bash)" # Zellij
# eval "$(register-python-argcomplete pipx)" # Pipx
#: }}}
