# vim:fileencoding=utf-8:foldmethod=marker

# --------------------------------------------------------------------------- #

#  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗    ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝    ██╔════╝██║██╔════╝██║  ██║
# ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗   █████╗  ██║███████╗███████║
# ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║   ██╔══╝  ██║╚════██║██╔══██║
# ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝██╗██║     ██║███████║██║  ██║
#  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝

# --------------------------------------------------------------------------- #

# If not running interactively, don't do anything.
if not status is-interactive; return; end

# Basics:
set fish_greeting    # Disables fish's intro message.
set fish_mode_prompt # Disables the prompt ability to show which vi mode you're in.

# (Vi mode) Change cursor shape to a block when in normal mode:
fish_vi_key_bindings # Enable vi mode.
set fish_cursor_insert line
set fish_cursor_default block
set fish_cursor_visual block
set fish_cursor_replace_one underscore

# Setup PATH:

# Source basic files:
set -l files (find "$HOME/.config/fish/core" -type f -printf '; source %p'); set -l files (string replace '; source ' 'source ' "$files"); eval "$files"

#: Keybindings {{{
# Open text editor buffer with ctrl-v:
bind -M default \cv 'edit_command_buffer'
bind -M insert \cv 'edit_command_buffer'

# Rebind Control+C to clear the input line:
# bind -M insert \cc kill-whole-line repaint

bind -M insert \cf 'fzf-hist; commandline -f repaint' # Run fzf-hist.
bind -M insert \ce 'fzf-configs; commandline -f repaint' # Edit files with an fzf script.
bind -M insert \co 'cdi; commandline -f repaint' # Open zoxide directory menu.
#: }}}
#: Shell prompt {{{
starship init fish | source ||
	function fish_prompt
		if test $status -ne 0
			string join '' --\
				(set_color blue --bold)$USER' '\
				(set_color white --bold)at' '\
				(set_color cyan --bold)$hostname' '\
				(set_color white --bold)on' '\
				(set_color magenta --bold)(date '+%r - %d/%m/%Y')' '\
				(set_color white --bold)using' '\
				(set_color green --bold)fish\n\
				(set_color red --bold)(prompt_pwd)' > '\
				(set_color normal)
		else
			string join '' --\
				(set_color blue --bold)$USER' '\
				(set_color white --bold)at' '\
				(set_color cyan --bold)$hostname' '\
				(set_color white --bold)on' '\
				(set_color magenta --bold)(date '+%r - %d/%m/%Y')' '\
				(set_color white --bold)using' '\
				(set_color green --bold)fish\n\
				(set_color white --bold)(prompt_pwd)" > "\
				(set_color normal)
		end
	end
#: }}}
#: Startup {{{
# Startx/Start Hyprland:
# if status is-login
# 	if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
# 		# sx "$XDG_CONFIG_HOME/x11/xinit"
# 		Hyprland
# 	end
# end

if test -z "$DISPLAY"
	set -l fastfetch_tty_theme "$HOME/.config/fastfetch/config-tty.jsonc"
	fastfetch --load-config "$fastfetch_tty_theme" && abbr cl "clear; fastfetch --load-config $fastfetch_tty_theme"
	set -x STARSHIP_CONFIG "$HOME/.config/starship.toml"
else
	fastfetch && abbr cl 'clear; fastfetch'
	set -x STARSHIP_CONFIG "$HOME/.cache/wal/colors-starship.toml"
end
zoxide init --cmd cd fish | source
#: }}}
