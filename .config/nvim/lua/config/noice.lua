local has_noice, noice = pcall(require, "noice")
if not has_noice then return end

local noice_lsp = require("noice.lsp")
local map = require("core.utils").map

-- stylua: ignore start
map("c", "<S-Enter>", function() noice.redirect(vim.fn.getcmdline()) end, "Redirect Cmdline")
map("n", "<Leader>ul", function() noice.cmd("last") end, "Noice Last Message")
map("n", "<Leader>uh", function() noice.cmd("history") end, "Noice History")
map("n", "<Leader>ua", function() noice.cmd("all") end, "Noice All")
map("n", "<Leader>ud", function() noice.cmd("dismiss")  end, "Dismiss All")
-- stylua: ignore end

map({ "n", "i", "s" }, "<C-f>", function()
    if not noice_lsp.scroll(4) then return "<C-f>" end
end, "Scroll Forward", { noremap = true, silent = true, expr = true })

map({ "n", "i", "s" }, "<C-b>", function()
    if not noice_lsp.scroll(-4) then return "<C-b>" end
end, "Scroll Backward", { noremap = true, silent = true, expr = true })

noice.setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    routes = {
        {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                },
            },
            view = "mini",
        },
    },
    presets = {
        long_message_to_split = true,
        inc_rename = true,
    },
})
