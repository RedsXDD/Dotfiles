local has_operators, operators = pcall(require, "mini.operators")
if not has_operators then return end

operators.setup({
    evaluate = {
        prefix = "<Leader>o=",
    },
    exchange = {
        prefix = "<Leader>ox",
        reindent_linewise = true,
    },
    multiply = {
        prefix = "<Leader>om",
    },
    replace = {
        prefix = "<Leader>or",
        reindent_linewise = true,
    },
    sort = {
        prefix = "<Leader>os",
    },
})
