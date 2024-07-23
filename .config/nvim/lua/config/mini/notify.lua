local has_notify, notify = pcall(require, "mini.notify")
if not has_notify then return end

notify.setup({
    lsp_progress = { enable = true },
    window = { config = { border = require("core.icons").misc.border } },
})
