#!/usr/bin/env sh

list_keybindings(){
	cat <<- EOF
		Prefix key                                         §§ <Control-a>
		Type 'Ctrl + a'                                    §§ <Prefix> + <Control-a>
		Toggle customize mode                              §§ <Prefix> + <Alt-c>
		Resource tmux.conf                                 §§ <Prefix> + R
		List keybindings                                   §§ <Prefix> + ?
		Enter copy mode                                    §§ <Prefix> + Space
		<COPY MODE> Copy selected text                     §§ y
		<COPY MODE> Go to the beginning of the line        §§ H
		<COPY MODE> Go to the end of the line              §§ L
		<COPY MODE> Toggle selection mode                  §§ v
		<COPY MODE> Toggle rectangle selection mode        §§ Control-v
		List all paste buffers                             §§ <Prefix> + b
		Delete most recent paste buffer                    §§ <Prefix> + B
		Paste the most recent paste buffer                 §§ <Prefix> + p
		Choose a paste buffer from a list                  §§ <Prefix> + P
		Split window horizontally                          §§ <Prefix> + -
		Split window vertically                            §§ <Prefix> + _
		Split window horizontally on CWD                   §§ <Prefix> + =
		Split window vertically on CWD                     §§ <Prefix> + +
		Select the next pane                               §§ <Prefix> + o
		Select the previous pane                           §§ <Prefix> + O
		Rotate through the panes                           §§ <Prefix> + ]
		Rotate through the panes in reverse                §§ <Prefix> + [
		Switch to previous layout                          §§ Alt-[
		Switch to next layout                              §§ Alt-]
		Select the pane to the left of the active pane     §§ Alt-h
		Select the pane below the active pane              §§ Alt-j
		Select the pane above the active pane              §§ Alt-k
		Select the pane to the right of the active pane    §§ Alt-l
		Resize pane to the left                            §§ Shift-Left
		Resize pane to the bottom                          §§ Shift-Down
		Resize pane to the top                             §§ Shift-Up
		Resize pane to the right                           §§ Shift-Right
		Switch to the marked pane                          §§ <Prefix> + '
		Synchronize all panes on currently active window   §§ <Prefix> + Y
		Create a new window                                §§ <Prefix> + c
		Create a new window on CWD                         §§ <Prefix> + C
		Prompt for window index to select                  §§ <Prefix> + w
		Choose a window from a list                        §§ <Prefix> + W
		Select the previously current window               §§ <Prefix> + a
		Rename currently active window                     §§ <Prefix> + i
		Prompt to kill currently active window             §§ <Prefix> + X
		Switch to window on the left                       §§ Alt-,
		Switch to window on the right                      §§ Alt-.
		Move active window to the left                     §§ Alt-H
		Move active window to the right                    §§ Alt-L
		Horizontally join panes to currently active window §§ <Prefix> + j
		Vertically join panes to currently active window   §§ <Prefix> + J
		Rename current session                             §§ <Prefix> + I
		Create new session                                 §§ <Prefix> + Control-c
		Kill current session                               §§ <Prefix> + Control-x
		Suspend the current client                         §§ <Prefix> + Control-z
		Break pane to a new window                         §§ <Prefix> + !
		Switch to previous client                          §§ <Prefix> + (
		Switch to next client                              §§ <Prefix> + )
		Describe key binding                               §§ <Prefix> + /
		Select window 1                                    §§ <Prefix> + 1
		Select window 2                                    §§ <Prefix> + 2
		Select window 3                                    §§ <Prefix> + 3
		Select window 4                                    §§ <Prefix> + 4
		Select window 5                                    §§ <Prefix> + 5
		Select window 6                                    §§ <Prefix> + 6
		Select window 7                                    §§ <Prefix> + 7
		Select window 8                                    §§ <Prefix> + 8
		Select window 9                                    §§ <Prefix> + 9
		Prompt for a command                               §§ <Prefix> + :
		Move to the previously active pane                 §§ <Prefix> + ;
		Choose and detach a client from a list             §§ <Prefix> + D
		Spread panes out evenly                            §§ <Prefix> + E
		Switch to the last client                          §§ <Prefix> + L
		Clear the marked pane                              §§ <Prefix> + M
		Detach the current client                          §§ <Prefix> + d
		Search for a pane                                  §§ <Prefix> + f
		Toggle the marked pane                             §§ <Prefix> + m
		Display pane numbers                               §§ <Prefix> + q
		Redraw the current client                          §§ <Prefix> + r
		Choose a session from a list                       §§ <Prefix> + s
		Show a clock                                       §§ <Prefix> + t
		Kill the active pane                               §§ <Prefix> + x
		Zoom the active pane                               §§ <Prefix> + z
		Swap the active pane with the pane above           §§ <Prefix> + {
		Swap the active pane with the pane below           §§ <Prefix> + }
		Show messages                                      §§ <Prefix> + ~
		Set the even-horizontal layout                     §§ <Prefix> + Alt-1
		Set the even-vertical layout                       §§ <Prefix> + Alt-2
		Set the main-horizontal layout                     §§ <Prefix> + Alt-3
		Set the main-vertical layout                       §§ <Prefix> + Alt-4
		Select the tiled layout                            §§ <Prefix> + Alt-5
		Select the next window with an alert               §§ <Prefix> + Alt-n
		Select the previous window with an alert           §§ <Prefix> + Alt-p
	EOF
}
keybinding="$(list_keybindings | column -t -s '§§' | fzf-tmux -p 76% -w 75% --prompt '> Search > ')"
[ -z "$keybinding" ] && exit 0

tmux display-message "$(echo $keybinding | sed 's/ \+/ /g')"
