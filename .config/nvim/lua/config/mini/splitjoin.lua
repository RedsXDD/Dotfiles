local has_splitjoin, splitjoin = pcall(require, "mini.splitjoin")
if not has_splitjoin then return end

splitjoin.setup({
    detect = { separator = "[,;]" },
    mappings = {
        toggle = "<Leader>jt",
        split = "<Leader>js",
        join = "<Leader>jj",
    },
})
