# vim:fileencoding=utf-8:foldmethod=marker:filetype=fish

function up
	set -l d ""
	set -l limit "$argv[1]"

	# Default to limit of 1
	if test -z "$limit" -o "$limit" -le 0
	    set -l limit 1
	end

	for i in (seq $limit)
	    set d "../$d"
	end

	# Perform cd. Show error if cd fails
	if not builtin cd "$d"
	    echo "Couldn't go up $limit dirs."
	end
end
