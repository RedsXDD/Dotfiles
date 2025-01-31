function __zoxide_zi
    [ -n "$DISPLAY" ] && set -l prompt '󰍉 Select Directory: ' || set -l prompt '* Select Directory: '
    set -l result (command zoxide query -ls -- "$argv" | sed "s/^\s\+\?//g; s|$HOME|~|g" | sk \
            -n2.. \
            --info=inline \
            --no-sort \
            --keep-right \
            --height=13 \
            --layout=reverse \
            --exit-0 \
            --select-1 \
            --preview-window=up:2 \
            --delimiter='[^\t\n ][\t\n ]+' \
            --prompt="$prompt" \
            --preview="
                set -l directory_path \"\$(readlink -f -- \"\$(echo {2..} | sed 's|~|$HOME|g')\")\"
                if ! which eza >/dev/null 2>&1
                    ls --group-directories-first --color=always -FAC \"\$directory_path\" || return 1
                    return 0
                end

                if [ -z \"\$DISPLAY\" ]
                    eza --group-directories-first --color=always --git-ignore -aF \"\$directory_path\" || return 1
                else
                    eza --group-directories-first --color=always --git-ignore --icons -aF \"\$directory_path\" || return 1
                end
                return 0
            " 2>/dev/null | sed "s|^\s\+\?[0-9]\+\.[0-9]\s\+\?||g; s|~|$HOME|g")
    [ -n "$result" ] && __zoxide_cd "$result"
end
