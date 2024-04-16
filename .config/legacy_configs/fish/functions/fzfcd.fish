# vim:fileencoding=utf-8:foldmethod=marker:filetype=fish

function fzfcd
	set -l choice "$(
		find "$HOME" -maxdepth 4 -type d -not -path "$HOME" |
		fzf-tmux -p 75% -w 75% --preview 'ls -lA {}' --prompt '> Change directory > '
	)"
	test -n "$choice" && cd "$choice"
end
