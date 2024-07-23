local M = {
    top_padding = 8,
    icons = require("core.icons").startpage,
    dashboard = {
        header = "",
        sections = {},
    },
    alpha = {
        header = {},
        sections = {},
    },
    starter = {
        header = "",
        sections = {},
        padding = string.rep(" ", 15),
    },
}

local header_text = [[TIP: To exit Neovim, just run $sudo rm -rf /*]]

local function lazy_load(plugin) require("lazy").load({ plugins = plugin }) end

local i = 0
---@param icon string
---@param desc string
---@param action function
local function new_section(icon, desc, action)
    i = i + 1

    if package.loaded["dashboard"] then
        table.insert(M.dashboard.sections, { key = "" .. i, icon = icon, desc = desc, action = action })
    elseif package.loaded["alpha"] then
        table.insert(M.alpha.sections, require("alpha.themes.dashboard").button("" .. i, "" .. icon .. desc, action))
    elseif package.loaded["mini.starter"] then
        table.insert(M.starter.sections, {
            name = "" .. icon .. desc,
            action = action,
            section = M.starter.padding .. M.icons.sections.actions .. "Actions",
        })
    end
end

M.dashboard.header = (function()
    local logo = ""

    for _, line in ipairs(M.icons.header) do
        logo = logo .. line .. "\n"
    end

    logo = logo .. "\n" .. header_text
    local header = string.rep("\n", M.top_padding) .. logo .. "\n\n"
    return vim.split(header, "\n")
end)()

M.alpha.header = (function()
    local logo = {}
    local header_padding = string.rep(" ", 12)

    for _, line in ipairs(M.icons.header) do
        table.insert(logo, line)
    end

    table.insert(logo, "")
    table.insert(logo, header_padding .. header_text)

    return logo
end)()

M.starter.header = (function()
    return table.concat({
        table.concat(M.icons.header, "\n"),
        "\n",
        "\n",
        M.starter.padding .. [[TIP: To exit Neovim, just run $sudo rm -rf /*]],
    })
end)()

new_section(M.icons.actions.new_file, "New File", function() vim.cmd([[enew | startinsert]]) end)

new_section(M.icons.actions.quit, "Quit Neovim", function() vim.cmd([[qa!]]) end)

new_section(
    M.icons.actions.file_explorer,
    "Open File Explorer",
    function() require("core.utils").toggle_file_explorer() end
)

new_section(M.icons.actions.list_buffers, "List Buffers", function()
    local has_pick, pick = pcall(require, "mini.pick")
    if has_pick then
        lazy_load("mini.pick")
        pick.builtin.buffers()
    end
end)

new_section(M.icons.actions.recent_files, "Recent Files", function()
    local has_pick, _ = pcall(require, "mini.pick")
    local has_extra, extra = pcall(require, "mini.extra")
    if has_pick and has_extra then
        lazy_load({ "mini.pick", "mini.extra" })
        extra.pickers.oldfiles()
    end
end)

new_section(M.icons.actions.find_files, "Find Files", function()
    local has_pick, pick = pcall(require, "mini.pick")
    if has_pick then
        lazy_load("mini.pick")
        pick.builtin.files()
    end
end)

new_section(M.icons.actions.live_grep, "Live Grep", function()
    local has_pick, pick = pcall(require, "mini.pick")
    if has_pick then
        lazy_load("mini.pick")
        pick.builtin.grep_live()
    end
end)

new_section(M.icons.actions.lazy, "Open Lazy.nvim", function() vim.cmd([[Lazy]]) end)

new_section(M.icons.actions.mason, "Open Mason", function() vim.cmd([[Mason]]) end)

return M
