local has_neopywal, neopywal = pcall(require, "neopywal")
if not has_neopywal then return end

vim.g.neopywal_debug = true

neopywal.setup({
    use_wallust = true,
    transparent_background = false,
    dim_inactive = true,
    show_split_lines = false,
    default_plugins = false,
    plugins = {
        dashboard = true,
        gitsigns = true,
        lazy = true,
        lsp = true,
        neotree = true,
        treesitter = true,
        symbols_outline = true,
        telescope = {
            enabled = true,
            style = "nvchad",
        },
        mini = {
            notify = true,
            surround = true,
            jump = true,
            jump2d = true,
            clue = true,
            hipatterns = true,
            indentscope = true,
            statusline = true,
            tabline = true,
        },
    },
})

neopywal.load()
