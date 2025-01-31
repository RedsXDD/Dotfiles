# If not running interactively, don't do anything.
not status is-interactive && return

function fish_greeting
    if ! which fastfetch >/dev/null 2>&1
        return
    end

    [ -n "$DISPLAY" ] && command fastfetch && return
    command fastfetch --load-config "$HOME/.config/fastfetch/config-tty.jsonc"
end

# (Vi mode) Change cursor shape to a block when in normal mode.
fish_vi_key_bindings # Enable vi mode.
set fish_cursor_insert line
set fish_cursor_default block
set fish_cursor_visual block
set fish_cursor_replace_one underscore

# Remove builtin functions.
functions --erase ll la

starship init fish | source
atuin init fish --disable-up-arrow | source
zoxide init --cmd cd fish | source
source "$HOME/.config/fish/functions/zi.fish"
