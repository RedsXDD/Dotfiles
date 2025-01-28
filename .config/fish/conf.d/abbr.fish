# If not running interactively, don't do anything.
not status is-interactive && return

abbr bc 'bc -lq'
abbr cal 'cal --color=auto -sy'
abbr cat bat
abbr chmod 'chmod --preserve-root -c'
abbr chown 'sudo chown --preserve-root -c'
abbr diff 'diff --color=auto -Ebsu'
abbr fc-cache 'fc-cache -rv'
abbr fd 'fd --color auto --hidden'
abbr free 'free -hwtl'
abbr grep 'grep --color=auto'
abbr mv 'mv -vi'
abbr cp 'cp -rvi'
abbr ln 'ln -svi'
abbr rm 'rm -rvI'
abbr mkdir 'mkdir -pv'
abbr tree 'tree --dirsfirst --gitignore -aFL 2 '
abbr df 'df -Th'
abbr du 'du -sh'
abbr ps 'ps -aux'
abbr ls 'eza -a'
abbr p 'paru --color=auto'
abbr lynx 'lynx -vikeys'
abbr glow 'glow -ap'
abbr info 'info --vi-keys --init-file ~/.config/infokey'
abbr q exit
abbr mpv 'mpv_wallust --fs'
abbr mvi 'mvi_wallust --fs'
abbr sudo 'doas --'
abbr doas 'doas --'
abbr su 'su -lw DISPLAY'
abbr yazi yazicd
abbr y yazicd
abbr yi 'cdi && yazicd'

for command in locale-gen make mount passwd mandb umount updatedb useradd userdel usermod smartctl
    abbr "$command" "sudo $command"
end

if [ -n "$DISPLAY" ]
    abbr lsblk 'lsblk -f'
    abbr eza 'eza --group-directories-first --color=always --icons'
else
    abbr duf 'duf -style ascii'
    abbr lsblk 'lsblk -if'
    abbr bat 'bat --decorations=never'
    abbr eza 'eza --group-directories-first --color=always'
    alias fastfetch='fastfetch --load-config "$HOME/.config/fastfetch/config-tty.jsonc"'
end
