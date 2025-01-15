local has_lspconfig, lspconfig = pcall(require, "lspconfig")
if not has_lspconfig then return end

-- Keymappings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
    callback = function()
        local lsp_map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { noremap = true, desc = "" .. desc })
        end

        lsp_map("<Leader>le", vim.diagnostic.open_float, "Show diagnostic error messages.")
        lsp_map("<Leader>lq", vim.diagnostic.setloclist, "Open diagnostic quickfix list.")
        lsp_map("<Leader>ld", vim.lsp.buf.definition, "Goto definition.")
        lsp_map("<Leader>lD", vim.lsp.buf.declaration, "Goto declaration.")
        lsp_map("<Leader>ls", vim.lsp.buf.signature_help, "Display signature help.")
        lsp_map("<Leader>la", vim.lsp.buf.code_action, "List code actions.")
        -- Replaced by snacks.nvim.
        -- lsp_map(
        --     "<Leader>li",
        --     function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        --     "Toggle inlay hints."
        -- )
        lsp_map("<Leader>lI", vim.lsp.buf.implementation, "Goto implementation.")
        lsp_map("<Leader>lR", vim.lsp.buf.references, "Goto references.")
        lsp_map("<Leader>lr", vim.lsp.buf.rename, "Rename.")
    end,
})

local opts = {
    capabilities = {},
    diagnostics = {
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = require("core.icons").diagnostics.Error,
                [vim.diagnostic.severity.WARN] = require("core.icons").diagnostics.Warn,
                [vim.diagnostic.severity.HINT] = require("core.icons").diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = require("core.icons").diagnostics.Info,
            },
        },
        virtual_text = {
            spacing = 4,
            source = "if_many",
            -- prefix = "●",
            prefix = "icons",
        },
        float = {
            focusable = true,
            style = "minimal",
            border = require("core.icons").misc.border,
            source = "always",
            header = "",
            prefix = "",
        },
    },
    servers = {
        lua_ls = {
            settings = {
                Lua = {
                    completion = { callSnippet = "Replace" },
                    diagnostics = { globals = { "vim" } },
                    hint = { enable = true },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        },
    },
    setup = {
        -- -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        -- 	require("typescript").setup({ server = opts })
        -- 	return true
        -- end,
        -- -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
    },
}

-- Configure diagnostics signs:
if vim.fn.has("nvim-0.10.0") == 0 then
    for severity, icon in pairs(opts.diagnostics.signs.text) do
        local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end
end

if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
    opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
        or function(diagnostic)
            local icons = require("core.icons").diagnostics
            for d, icon in pairs(icons) do
                if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
            end
        end
end
vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

-- Nvim_cmp configuration:
local servers = opts.servers
local has_nvim_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_nvim_cmp and cmp_nvim_lsp.default_capabilities() or {},
    opts.capabilities or {}
)

-- Get all the servers that are available through mason-lspconfig:
local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
    }, servers[server] or {})

    if opts.setup[server] then
        if opts.setup[server](server, server_opts) then return end
    elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then return end
    end
    lspconfig[server].setup(server_opts)
end

local has_mason, mason_lsp = pcall(require, "mason-lspconfig")
local all_mason_lsp_servers = {}
if has_mason then
    all_mason_lsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
end

local ensure_installed = {}
for server, server_opts in pairs(servers) do
    if server_opts then
        server_opts = server_opts == true and {} or server_opts
        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(all_mason_lsp_servers, server) then
            setup(server)
        elseif server_opts.enabled ~= false then
            ensure_installed[#ensure_installed + 1] = server
        end
    end
end

if has_mason then mason_lsp.setup({ ensure_installed = ensure_installed, handlers = { setup } }) end
