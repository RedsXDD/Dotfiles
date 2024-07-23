local has_indentscope, indentscope = pcall(require, "mini.indentscope")
if not has_indentscope then return end

indentscope.setup({
    draw = {
        animation = function() return 1 end,
    },
    options = { try_as_border = true },
    symbol = require("core.icons").misc.indent,
})
