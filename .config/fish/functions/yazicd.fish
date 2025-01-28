function yazicd
    set -l yazi_path "$(pwd)"
    set -l exited_path "$(mktemp -t "yazi_cwd.XXXXXXXXXX")"

    set -l zoxide_query "$(zoxide query -- "$argv" 2>/dev/null)"
    [ -n "$argv" ] && [ -n "$zoxide_query" ] &&
        builtin cd -- "$zoxide_query" &&
        set yazi_path "$zoxide_query"

    set -l STARSHIP_CONFIG "$HOME/.config/yazi/starship.toml"
    yazi --cwd-file="$exited_path" "$yazi_path"

    # Check if cwd was written to exited_path and change directory if needed
    set -l cwd "$(command cat "$exited_path")"
    if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd" || exit 1
    end

    rm -rf "$exited_path" >/dev/null 2>&1
end
