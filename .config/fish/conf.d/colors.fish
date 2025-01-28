# Only run on login.
not status is-login && return

# Erase any previously set color variable (prevents variable shadowing).
set --erase fish_color_normal
set --erase fish_color_command
set --erase fish_color_keyword
set --erase fish_color_quote
set --erase fish_color_redirection
set --erase fish_color_end
set --erase fish_color_error
set --erase fish_color_param
set --erase fish_color_comment
set --erase fish_color_selection
set --erase fish_color_search_match
set --erase fish_color_history_current
set --erase fish_color_operator
set --erase fish_color_escape
set --erase fish_color_option
set --erase fish_color_valid_path
set --erase fish_color_autosuggestion
set --erase fish_color_cwd
set --erase fish_color_cwd_root
set --erase fish_color_user
set --erase fish_color_host
set --erase fish_color_host_remote
set --erase fish_color_status
set --erase fish_color_cancel
set --erase fish_pager_color_prefix
set --erase fish_pager_color_progress
set --erase fish_pager_color_completion
set --erase fish_pager_color_description
set --erase fish_pager_color_selected_background
set --erase fish_pager_color_secondary_completion
set --erase fish_pager_color_selected_completion
set --erase fish_pager_color_secondary_prefix
set --erase fish_pager_color_selected_description
set --erase fish_pager_color_selected_prefix
set --erase fish_pager_color_secondary_background
set --erase fish_pager_color_secondary_description
set --erase fish_pager_color_background

# Syntax.
set -U fish_color_normal normal # default color.
set -U fish_color_command green # commands like echo.
set -U fish_color_keyword red # keywords like if - this falls back on the command color if unset.
set -U fish_color_quote yellow # quoted text like "abc".
set -U fish_color_redirection cyan --bold # IO redirections like >/dev/null.
set -U fish_color_end yellow # process separators like ; and &.
set -U fish_color_error red # syntax errors.
set -U fish_color_param brblue # ordinary command parameters.
set -U fish_color_comment brblack # comments like ‘# important’.
set -U fish_color_selection magenta --background=brblack --bold # selected text in vi visual mode.
set -U fish_color_history_current blue --bold # the current position in the history for commands like dirh and cdh.
set -U fish_color_operator yellow # parameter expansion operators like * , ~ and &&.
set -U fish_color_escape magenta # character escapes like \n and \x70.
set -U fish_color_option magenta # options starting with “-”, up to the first “--” parameter.
set -U fish_color_valid_path --underline # parameters that are filenames (if the file exists).
set -U fish_color_autosuggestion brblack # autosuggestions (the proposed rest of a command).

# Prompt.
set -U fish_color_cwd brblue # the current working directory in the default prompt.
set -U fish_color_cwd_root red # the current working directory in the default prompt for the root user.
set -U fish_color_user brgreen # the username in the default prompt.
set -U fish_color_host brgreen # the hostname in the default prompt.
set -U fish_color_host_remote yellow # the hostname in the default prompt for remote sessions (like ssh).
set -U fish_color_status red # the last command’s nonzero exit code in the default prompt.
set -U fish_color_cancel --reverse # the ‘^C’ indicator on a canceled command.

# Pager.
set -U fish_color_search_match magenta --bold --reverse # history search matches and selected pager items (background only).
set -U fish_pager_color_background # the background color of a line.
set -U fish_pager_color_completion normal # the completion itself, i.e. the proposed rest of the string.
set -U fish_pager_color_description bryellow --italics # the completion description.
set -U fish_pager_color_prefix magenta --bold # the prefix string, i.e. the string that is to be completed.
set -U fish_pager_color_progress cyan --reverse --bold # the progress bar at the bottom left corner.
set -U fish_pager_color_secondary_background # background of every second unselected completion.
set -U fish_pager_color_secondary_completion # suffix of every second unselected completion.
set -U fish_pager_color_secondary_description # description of every second unselected completion.
set -U fish_pager_color_secondary_prefix # prefix of every second unselected completion.
set -U fish_pager_color_selected_background --reverse # background of the selected completion.
set -U fish_pager_color_selected_completion bryellow # suffix of the selected completion.
set -U fish_pager_color_selected_description # description of the selected completion.
set -U fish_pager_color_selected_prefix # prefix of the selected completion.

# Valid colors.
# normal
# black
# red
# green
# yellow
# blue
# magenta
# cyan
# white
# brblack
# brred
# brgreen
# bryellow
# brblue
# brmagenta
# brcyan
# brwhite
