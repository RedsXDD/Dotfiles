function l.
	# [ -z "$1" ] && ls -1d .* || ls -1d -- "$argv"/.* | awk -F '/' '{print $NF}'
	# [ -z "$1" ] && lsd -1d .* || lsd -1d -- "$argv"/.* | awk -F '/' '{print $NF}'
	[ -z "$1" ] && eza -1d .* || eza -1d -- "$argv"/.* | awk -F '/' '{print $NF}'
end
