local has_splitjoin, splitjoin = pcall(require, "mini.splitjoin")
if not has_splitjoin then return end

splitjoin.setup({
    detect = { separator = "[,;]" },
    mappings = {
        toggle = "<Leader>oo",
        split = "<Leader>ot",
        join = "<Leader>oj",
    },
})
