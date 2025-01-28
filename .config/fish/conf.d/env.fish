# Only run on login.
not status is-login && return

#: XDG directory specifications {{{
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_STATE_HOME "$HOME/.local/state"

# set -Ux RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/config"
set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -Ux CARGO_HOME "$XDG_DATA_HOME/cargo"
set -Ux GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -Ux GOMODCACHE "$XDG_CACHE_HOME/go/mod"
set -Ux GOPATH "$XDG_DATA_HOME/go"
set -Ux GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set -Ux LYNX_CFG_PATH "$XDG_CONFIG_HOME/lynx.cfg"
set -Ux NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -Ux SQLITE_HISTORY "$XDG_DATA_HOME/sqlite_history"
set -Ux TERMINFO "$XDG_DATA_HOME/terminfo"
set -Ux TERMINFO_DIRS "$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
set -Ux TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -Ux WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
set -Ux XINITRC "$XDG_CONFIG_HOME/X11/xinitrc"
set -Ux XSERVERRC "$XDG_CONFIG_HOME/X11/xserverrc"
set -Ux _JAVA_OPTIONS "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
#: }}}
#: Defaults {{{
set -Ux BROWSER librewolf
set -Ux COLORTERM truecolor
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux MANPAGER 'nvim +Man!'
set -Ux PAGER less
set -Ux IMAGE mvi
set -Ux OPENER xdg-open
set -Ux READER zathura
set -Ux TERMINAL wezterm
set -Ux VIDEO mpv
#: }}}
#: PATH {{{
find "$HOME/.local/bin" -follow -type d -not -path "$HOME/.local/bin/not_path/*" -not -path "$HOME/.local/bin/not_path" | xargs -I {} fish -c 'fish_add_path "$argv"' {}
fish_add_path "$HOME/Applications" "$CARGO_HOME/bin" "$GOPATH/bin"
#: }}}
#: Program configs {{{
set -Ux RUSTC_WRAPPER sccache
set -Ux BAT_THEME ansi
set -Ux ZELLIJ_AUTO_ATTACH true
set -Ux ZELLIJ_AUTO_EXIT true
set -Ux _ZO_EXCLUDE_DIRS "$XDG_CACHE_HOME:$XDG_CACHE_HOME/*" # Zoxide.
[ -f "$XDG_CONFIG_HOME/starship/starship.toml" ] && set -Ux STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"

# Ls colors (perhaps not needed).
dircolors | sed '/export/d; s/^/set -Ux /; s/;$//; s/LS_COLORS=/LS_COLORS /' | source

set -Ux QT_QPA_PLATFORMTHEME qt6ct # Qt style.
set -Ux OOMOX_QTSTYLEPLUGIN_THEME oomox_wallust # Qt oomox config.

# Fcitx.
# set -Ux GTK_IM_MODULE 'fcitx'
set -Ux QT_IM_MODULE fcitx
set -Ux XMODIFIERS '@im=fcitx'
set -Ux SDL_IM_MODULE fcitx
set -Ux GLFW_IM_MODULE ibus # IME support for kitty

# Swww.
set -Ux SWWW_TRANSITION any
set -Ux SWWW_TRANSITION_STEP 90
set -Ux SWWW_TRANSITION_DURATION 1
set -Ux SWWW_TRANSITION_FPS 60
set -Ux SWWW_TRANSITION_ANGLE 45
# set -Ux SWWW_TRANSITION_POS 'center'
set -Ux SWWW_TRANSITION_BEZIER '.43,1.19,1,.4'
# set -Ux SWWW_TRANSITION_WAVE '20,20'

# FZF.
set -Ux FZF_DEFAULT_COMMAND 'fd --type f --color always || find . --type f'
set -Ux FZF_TMUX_OPTS '-p 75% -w 75%'
set -Ux FZF_DEFAULT_OPTS \
    "--color=bg:-1,bg+:0" \
    "--color=fg:-1,fg+:-1" \
    "--color=hl:magenta,hl+:magenta" \
    "--color=border:-1" \
    "--color=label:yellow" \
    "--color=prompt:blue" \
    "--color=spinner:yellow" \
    "--color=info:cyan" \
    "--color=marker:red" \
    "--color=pointer:blue" \
    "--color=header:yellow" \
    --cycle \
    --ansi \
    "--preview-window='border-rounded'" \
    "--padding='1'" \
    "--prompt='󰍉 '" \
    "--marker='>'" \
    "--pointer='◆'" \
    "--separator='─'" \
    "--layout='reverse'" \
    "--height='~62%'"
#: }}}
#: Less {{{
set -Ux LESS '--exit-follow-on-close --mouse --wheel-lines=5 --wordwrap --ignore-case --quit-if-one-screen --LONG-PROMPT --RAW-CONTROL-CHARS'
set -Ux LESSHISTFILE "$XDG_CACHE_HOME/lesshst"
set -Ux LESSHISTSIZE 10000

# Less color configuration, tput information can be found at man terminfo.
set -Ux LESS_TERMCAP_mb "$(tput bold; tput setaf 2)" # Start blinking, green
set -Ux LESS_TERMCAP_md "$(tput bold; tput setaf 4)" # Start bold, cyan
set -Ux LESS_TERMCAP_me "$(tput sgr0)" # End bold, blinking, standout, underline
set -Ux LESS_TERMCAP_so "$(tput bold; tput setaf 4; tput rev)" # Start stand out, cyan, reverse.
set -Ux LESS_TERMCAP_se "$(tput rmso; tput sgr0)" # End standout, reset
set -Ux LESS_TERMCAP_us "$(tput smul; tput bold; tput setaf 1)" # Start underline, bold, red
set -Ux LESS_TERMCAP_ue "$(tput sgr0)" # End Underline
set -Ux LESS_TERMCAP_mr "$(tput rev)" # Reverse background/foreground colors.
set -Ux LESS_TERMCAP_mh "$(tput dim)" # Enter dim mode.
set -Ux LESS_TERMCAP_ZN "$(tput ssubm)" # Enter subscript mode.
set -Ux LESS_TERMCAP_ZV "$(tput rsubm)" # End subscript mode.
set -Ux LESS_TERMCAP_ZO "$(tput ssupm)" # Enter superscript mode.
set -Ux LESS_TERMCAP_ZW "$(tput rsupm)" # End superscript mode.
#: }}}
#: TTY stuff (must be last!) {{{
if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" != /dev/tty2 ]
    set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --no-unicode --pointer='*' --prompt='> '"
    [ -f "$XDG_CONFIG_HOME/starship/starship_tty.toml" ] && set -Ux STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship_tty.toml"
    [ -f "$XDG_CACHE_HOME/wallust/colors_tty.sh" ] && . "$XDG_CACHE_HOME/wallust/colors_tty.sh"
end
#: }}}
