local has_mason, mason = pcall(require, "mason")
if not has_mason then return end

local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not has_mason_lspconfig then return end

local has_mason_tool_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
if not has_mason_tool_installer then return end

local icons = require("reds.icons").mason
local border_style = require("reds.icons").misc.border

vim.keymap.set("n", "<Leader>gm", "<CMD>Mason<CR>", { noremap = true, desc = "Open Mason UI." })

mason.setup({
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    ui = {
        border = border_style,
        icons = {
            package_installed = icons.installed,
            package_pending = icons.pending,
            package_uninstalled = icons.uninstalled,
        },
    },
})

mason_lspconfig.setup({})
mason_tool_installer.setup({
    ensure_installed = {
        "taplo",
        "stylua",
        "lua_ls",
        "bashls",
        "clangd",
        "yamlls",
        "rust-analyzer",
        "shfmt",
        "prettier",
        "eslint_d",
        "isort",
        "black",
        "pylint",
    },
})
