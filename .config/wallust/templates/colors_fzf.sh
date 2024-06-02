export FZF_DEFAULT_OPTS="\
	${FZF_DEFAULT_OPTS} \
	--color=bg:-1,bg+:{{background | lighten(0.1)}},fg:-1,fg+:-1 \
	--color=hl:{{color4}},hl+:{{color4}},info:{{foreground}},marker:{{color2}} \
	--color=prompt:{{color6}},spinner:{{color11}},pointer:{{color6}},header:{{color3}} \
	--color=border:{{foreground}},label:{{color6}},query:{{foreground}} \
	--border='rounded' \
	--border-label='' \
	--preview-window='border-rounded' \
	--padding='1' \
	--prompt='> ' \
	--marker='>' \
	--pointer='◆' \
	--separator='─' \
	--no-scrollbar \
	--layout='reverse'"
