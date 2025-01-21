local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then return end

local has_plenary_Job, Job = pcall(require, "plenary.job")
if not has_plenary_Job then return end

local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local previewers = require("telescope.previewers")
local icons = require("reds.icons").telescope
local map = require("reds.utils").map

-- Load telescope extensions:
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "noice")
pcall(telescope.load_extension, "ui-select")

-- stylua: ignore start
-- Main:
map("n", "<Leader>?", function() builtin.keymaps() end, "Search keymaps.")
map("n", "<Leader>f?", function() builtin.help_tags() end, "Search help tags.")
map("n", "<Leader>ft", function() builtin.tags() end, "Search tags.")
map("n", "<Leader>fT", function() builtin.current_buffer_fuzzy_find() end, "Search tags on current buffer.")
map("n", "<Leader>fh", function() builtin.command_history() end, "Search command history.")
map("n", "<Leader>fS", function() builtin.search_history() end, "Search search history.")
map("n", "<Leader>fr", function() builtin.registers() end, "Search registers.")
map("n", "<Leader>fs", function() builtin.spell_suggest() end, "Search spell suggestions.")
map("n", "<Leader>fn", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, "Search Neovim configuration files.")
map("n", "<Leader>fm", function() builtin.marks() end, "Search marks.")
map("n", "<Leader>fM", function() builtin.man_pages() end, "Search man pages.")

-- Lists:
map("n", "<Leader>fq", function() builtin.quickfix() end, "Search quickfix list.")
map("n", "<Leader>fQ", function() builtin.quickfixhistory() end, "Search quickfix list history.")
map("n", "<Leader>fL", function() builtin.loclist() end, "Search location list.")
map("n", "<Leader>fj", function() builtin.jumplist() end, "Search jumplist.")

-- Buffers:
map("n", "<Leader>fb", function() builtin.buffers() end, "Search buffers.")
map("n", "<Leader>fB", function() builtin.current_buffer_fuzzy_find() end, "Search lines in current buffer.")

-- File searching:
map("n", "<Leader>ff", function() builtin.find_files({ follow = true, no_ignore = true, hidden = true }) end, "Find files on CWD (+ hidden files).")
map("n", "<Leader>fo", function() builtin.oldfiles() end, "Search recently opened files.")

-- Extra
map("n", "<Leader>feo", function() builtin.vim_options() end, "Search options.")
map("n", "<Leader>fec", function() builtin.commands() end, "Search commands.")
map("n", "<Leader>feC", function() builtin.colorscheme() end, "Search colorschemes.")
map("n", "<Leader>fea", function() builtin.autocommands() end, "Search autocommands.")
map("n", "<Leader>fet", function() builtin.filetypes() end, "Search filetypes.")
map("n", "<Leader>feh", function() builtin.highlights() end, "Search highlight groups.")
map("n", "<Leader>fet", function() builtin.treesitter() end, "Search treesitter nodes.")

-- Grep & git:
map("n", "<Leader>fgw", function() builtin.grep_string() end, "Search word under cursor.")
map("n", "<Leader>fgl", function() builtin.live_grep() end, "Live grep for files on CWD.")
map("n", "<Leader>fgo", function() builtin.live_grep({ grep_open_files = true, prompt_title = "Grep on open files." }) end, "Grep on open files.")
map("n", "<Leader>fgb", function() builtin.git_branches() end, "Search git branches.")
map("n", "<Leader>fgc", function() builtin.git_commits() end, "Search git commits.")
map("n", "<Leader>fgf", function() builtin.git_files() end, "Search git files.")
map("n", "<Leader>fgh", function() builtin.git_status() end, "Search git hunks.")
map("n", "<Leader>fgs", function() builtin.git_stash() end, "Search git stash.")

-- LSP:
map("n", "<Leader>fd", function() builtin.diagnostics() end, "Search diagnostics.")
map("n", "<Leader>fld", function() builtin.lsp_definitions() end, "Search definition(s).")
map("n", "<Leader>fls", function() builtin.lsp_document_symbols() end, "Search document symbol(s).")
map("n", "<Leader>fli", function() builtin.lsp_implementations() end, "Search implementation(s).")
map("n", "<Leader>flI", function() builtin.lsp_incoming_calls() end, "Search incoming call(s).")
map("n", "<Leader>flo", function() builtin.lsp_outgoing_calls() end, "Search outgoing call(s).")
map("n", "<Leader>flr", function() builtin.lsp_references() end, "Search reference(s).")
map("n", "<Leader>flt", function() builtin.lsp_type_definitions() end, "Search type definition(s).")
map("n", "<Leader>flw", function() builtin.lsp_workspace_symbols() end, "Search workspace symbol(s).")
map("n", "<Leader>flW", function() builtin.lsp_dynamic_workspace_symbols() end, "Search workspace symbol(s) dynamically.")
-- stylua: ignore end

local function formattedName(_, path)
    local tail = vim.fs.basename(path)
    local parent = vim.fs.dirname(path)
    if parent == "." then return tail end
    return string.format("%s\t\t%s", tail, parent)
end

-- Function to disable binary previewing:
local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function() vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" }) end)
            end
        end,
    }):sync()
end

telescope.setup({
    file_ignore_patterns = { "%.git/." },
    defaults = {
        preview = true,
        prompt_prefix = icons.prompt_prefix,
        selection_caret = icons.selection_caret,
        file_ignore_patterns = { "node_modules", "package-lock.json" },
        initial_mode = "insert",
        select_strategy = "reset",
        sorting_strategy = "ascending",
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        buffer_previewer_maker = new_maker, -- Set previewer to `Disable binaries` function.
        layout_config = {
            prompt_position = "top",
            preview_cutoff = 120,
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
        },
        mappings = {
            i = {
                ["<Esc>"] = actions.close,
                ["<C-u>"] = false,
                ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
                ["<C-k>"] = {
                    actions.move_selection_previous,
                    type = "action",
                    opts = { nowait = true, silent = true },
                },
                ["<C-j>"] = {
                    actions.move_selection_next,
                    type = "action",
                    opts = { nowait = true, silent = true },
                },
                ["<M-p>"] = action_layout.toggle_preview,
            },
        },
    },
    pickers = {
        find_files = {
            preview = false,
            path_display = formattedName,
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
            layout_config = {
                height = 0.4,
                prompt_position = "top",
                preview_cutoff = 120,
            },
        },
        git_files = {
            previewer = true,
            path_display = formattedName,
            layout_config = {
                height = 0.4,
                prompt_position = "top",
                preview_cutoff = 120,
            },
        },
        buffers = {
            previewer = false,
            path_display = formattedName,
            layout_config = {
                height = 0.4,
                width = 0.6,
                prompt_position = "top",
                preview_cutoff = 120,
            },
            mappings = {
                i = { ["<c-d>"] = actions.delete_buffer },
                n = { ["<c-d>"] = actions.delete_buffer },
            },
        },
        current_buffer_fuzzy_find = {
            previewer = true,
            layout_config = {
                prompt_position = "top",
                preview_cutoff = 120,
            },
        },
        live_grep = { only_sort_text = true, previewer = true },
        grep_string = { only_sort_text = true, previewer = true },
        lsp_references = { show_line = false, previewer = true },
        treesitter = { show_line = false, previewer = true },
        colorscheme = { enable_preview = true },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        ["ui-select"] = {
            themes.get_dropdown({
                previewer = true,
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        width = 0.5,
                        height = 0.4,
                        preview_width = 0.6,
                    },
                },
            }),
        },
    },
})
