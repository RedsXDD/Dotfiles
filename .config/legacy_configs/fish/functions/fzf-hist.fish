# vim:fileencoding=utf-8:foldmethod=marker:filetype=fish

function fzf-hist
	set -l choice "$(history |
				sort | uniq -c | sort -nr |
				fzf-tmux -p 50% -w 50% --prompt 'History Search > ' |
				awk -v n=2 '{for (i=n; i<=NF; i++) printf "%s%s", $i, (i<NF ? OFS : ORS)}')"
	test -n "$choice" && wtype "$choice"
end
