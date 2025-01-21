local has_tabline, tabline = pcall(require, "mini.tabline")
if not has_tabline then return end

local show_icons = true
if vim.env.DISPLAY == nil then show_icons = false end

-- Disable on certain filetypes
local disabled_filetypes = { "snacks_dashboard", "dashboard", "alpha", "starter" }
vim.api.nvim_create_autocmd("FileType", {
    desc = "Auto disable mini.tabline on certain filetypes.",
    group = vim.api.nvim_create_augroup("augroup_" .. "auto_disable_mini_tabline", { clear = true }),
    pattern = disabled_filetypes,
    callback = function() vim.b.minitabline_disable = true end,
})

tabline.setup({
    show_icons = show_icons,
    set_vim_settings = true, -- Whether to set Vim's settings for tabline (make it always shown and allow hidden buffers).
    tabpage_section = "right", -- Where to show tabpage section in case of multiple vim tabpages.
})
