local function augroup(name) return vim.api.nvim_create_augroup("augroup_" .. name, { clear = true }) end

-- Check if we need to reload the file when it changed.
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Check if we need to reload the file when it changed.",
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
    end,
})

-- Disable line numbers inside neovim's terminal.
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Disable line numbers inside neovim's terminal.",
    group = augroup("disable_linenumbers_on_term"),
    callback = function()
        vim.o.number = false
        vim.o.relativenumber = false
    end,
})

-- Highlight when yanking (copying) text.
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text.",
    group = augroup("highlight_yank"),
    pattern = "*",
    callback = function() vim.highlight.on_yank() end,
})

-- Resize splits if window got resized.
vim.api.nvim_create_autocmd("VimResized", {
    desc = "Resize splits if window got resized.",
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- Don't insert comments on newlines.
vim.api.nvim_create_autocmd("FileType", {
    desc = "Disable inserting comments when creating a newline below one.",
    group = augroup("disable_newline_comments"),
    pattern = "*",
    callback = function() vim.o.formatoptions = vim.o.formatoptions:gsub("cro", "") end,
})

-- Close some filetypes with <q>.
vim.api.nvim_create_autocmd("FileType", {
    desc = "Close with <q>.",
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "notify",
        "qf",
        "query",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Make it easier to close man-files when opened inline.
vim.api.nvim_create_autocmd("FileType", {
    desc = "Close man pages.",
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event) vim.bo[event.buf].buflisted = false end,
})

-- Wrap and check for spell in text filetypes.
vim.api.nvim_create_autocmd("FileType", {
    desc = "Wrap and check for spell in text filetypes.",
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Fix conceallevel for json files.
vim.api.nvim_create_autocmd("FileType", {
    desc = "Fix conceallevel for json files.",
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function() vim.opt_local.conceallevel = 0 end,
})

-- Auto create directories when saving a file, in case some intermediate directory does not exist.
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Auto create directories when saving a file.",
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then return end
        ---@diagnostic disable-next-line: undefined-field
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Set tmux filetype for *.tmux files.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    desc = "Set tmux filetype for *.tmux files.",
    group = augroup("set_tmux_filetype"),
    pattern = "*.tmux",
    command = "set filetype=tmux",
})

--  Automatically deletes all trailing whitespace and newlines at end of file on save.
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Automatically deletes all trailing whitespace and newlines at end of file on save.",
    group = augroup("delete_trailspace"),
    command = [[
		let currPos = getpos(".")
		%s/\s\+$//e
		%s/\n\+\%$//e
		call cursor(currPos[1], currPos[2])
	]],
})
