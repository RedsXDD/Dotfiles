local has_hardtime, hardtime = pcall(require, "hardtime")
if not has_hardtime then return end

hardtime.setup({
    allow_different_key = false,
    disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "minifiles", "noice" },
})
