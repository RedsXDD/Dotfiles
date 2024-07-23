local has_zenmode, zenmode = pcall(require, "zen-mode")
if not has_zenmode then return end

vim.keymap.set({ "n", "v" }, "<leader>tz", function()
    require("zen-mode").toggle()
    vim.notify("Toggled zenmode", vim.log.levels.INFO)
end, { noremap = true, desc = "Toggle Zenmode." })

zenmode.setup({
    window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
            wrap = false,
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            -- list = false,
        },
    },
    plugins = {
        options = {
            enabled = true,
            ruler = false,
            showcmd = false,

            -- You may turn on/off statusline in zen mode by setting 'laststatus'.
            -- Statusline will be shown only if 'laststatus' == 3.
            laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = true },
        alacritty = {
            enabled = true,
            font = "14",
        },

        -- This will change the font size on kitty when in zen mode
        -- To make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
            enabled = true,
            font = "+2",
        },
    },
})
