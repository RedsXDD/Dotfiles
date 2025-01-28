# If not running interactively, don't do anything.
not status is-interactive && return

# Disable unnecessary keymaps.
for key in left down up right home end pageup pagedown ctrl-m ctrl-j ctrl-right ctrl-left alt-h alt-p alt-v alt-e alt-l
    bind -M default "$key" ''
    bind -M visual "$key" ''
    bind -M insert "$key" ''
end
bind -M insert ctrl-p forward-char # Commandline history completion.

# Open text editor buffer with Ctrl-v.
bind -M default ctrl-v edit_command_buffer
bind -M visual ctrl-v edit_command_buffer
bind -M insert ctrl-v edit_command_buffer

# Search history with Ctrl-k/Ctrl-j
for mode in default insert visual
    bind -M "$mode" ctrl-k up-or-search
    bind -M "$mode" ctrl-j down-or-search
end
