require("zoxide"):setup({
	update_db = true,
})

require("copy-file-contents"):setup({
	append_char = "\n",
	notification = true,
})

-- Git.yazi
THEME.git = THEME.git or {}
THEME.git.added = ui.Style():fg("green")
THEME.git.deleted = ui.Style():fg("red")
THEME.git.ignored = ui.Style():fg("lightmagenta")
THEME.git.modified = ui.Style():fg("cyan")
THEME.git.untracked = ui.Style():fg("magenta")
THEME.git.updated = ui.Style():fg("lightcyan")

if os.getenv("DISPLAY") then
	THEME.git.added_sign = "✚"
	THEME.git.deleted_sign = "✖"
	THEME.git.ignored_sign = ""
	THEME.git.modified_sign = ""
	THEME.git.untracked_sign = ""
	THEME.git.updated_sign = ""
else
	THEME.git.added_sign = "+"
	THEME.git.deleted_sign = "-"
	THEME.git.ignored_sign = "#"
	THEME.git.modified_sign = "~"
	THEME.git.untracked_sign = "?"
	THEME.git.updated_sign = "@"
end

require("git"):setup()

-- Show symlinks on status bar.
function Status:name()
	local h = self._current.hovered
	if not h then
		return ""
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end
	return ui.Line(" " .. h.name .. linked)
end

-- Show user/group of files in status bar.
Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	})
end, 500, Status.RIGHT)
