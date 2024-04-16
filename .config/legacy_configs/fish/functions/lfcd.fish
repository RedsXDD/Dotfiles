# vim:fileencoding=utf-8:foldmethod=marker:filetype=fish

function lfcd
	# Setup a new lfrc if lf is running on a tty environment (AKA remove icons from lfrc).
	function cleanup
		sh "$HOME/.config/lf/lf-cleaner" # Useful for cleaning image previews.
		rm -rf $tmp_conf $last_path_file >/dev/null 2>&1 || true
		functions -e cleanup
	end
	trap cleanup 0 1 15

	# Define paths and configurations:
	set -l lfrc "$HOME/.config/lf/lfrc" # Location of lfrc.
	set -l tmp_conf (mktemp) # Temporary lfrc file.

	# Check if running on a graphical environment.
	if test -n "$DISPLAY"
		cp $lfrc $tmp_conf # Copy lfrc to temporary file.
	else
		sed "s/set\s\+icons\s\+true/set icons false/g" $lfrc > $tmp_conf # Remove icons if running on a tty.
	end

	set -l last_path_file (mktemp) # Temporary file to store last visited directory.

	# Check if there are arguments provided and zoxide is installed.
	if test (count $argv) -gt 0 && command -v zoxide >/dev/null
		# Execute zoxide query if there are arguments provided:
		set -l zoxide_query (zoxide query $argv 2>/dev/null)

		# Check if zoxide query returned a valid directory.
		if test -n "$zoxide_query" && test -d "$zoxide_query"
			# Change directory to the result of zoxide query and run lf with configurations.
			builtin cd $zoxide_query && lf -config $tmp_conf -last-dir-path=$last_path_file || return $status
		else
			# Run lf with configurations without using zoxide first:
			if test -d "$argv"
				lf -config $tmp_conf -last-dir-path=$last_path_file "$argv" || return $status
			else
				lf -config $tmp_conf -last-dir-path=$last_path_file || return $status
			end
		end
	else
		# Run lf without zoxide query if zoxide is not installed or no arguments provided.
		lf -config $tmp_conf -last-dir-path=$last_path_file || return $status
	end

	# Check if last_path_file exists.
	if test -f $last_path_file
		set -l dir (cat $last_path_file) # Read last visited directory from last_path_file.

		# Check if the directory exists and is different from the current directory:
		if test -d $dir && test "$dir" != (pwd)
			builtin cd $dir || return $status # Change directory to last visited directory.
		end
	end
end
