local has_neopywal, neopywal = pcall(require, "neopywal")
if not has_neopywal then
    vim.cmd.colorscheme("desert")
    return
end

vim.g.neopywal_debug = true

neopywal.setup({
    use_palette = "wallust",
    transparent_background = false,
    dim_inactive = true,
    show_split_lines = false,
    default_plugins = false,
    plugins = {
        lazy = true,
        lsp = true,
        mason = true,
        noice = true,
        nvim_cmp = true,
        snacks = true,
        symbols_outline = true,
        treesitter = true,
        telescope = {
            enabled = true,
            style = "nvchad",
        },
        mini = {
            clue = true,
            diff = true,
            files = true,
            hipatterns = true,
            icons = true,
            jump2d = true,
            statusline = true,
            surround = true,
            tabline = true,
        },
    },
    custom_highlights = {
        all = function(C)
            return {
                CmpItemKindArray = { bg = C.special, fg = C.background },
                CmpItemKindBoolean = { bg = C.boolean, fg = C.background },
                CmpItemKindClass = { bg = C.type, fg = C.background },
                CmpItemKindColor = { bg = C.constant, fg = C.background },
                CmpItemKindConstant = { bg = C.constant, fg = C.background },
                CmpItemKindConstructor = { bg = C.special, fg = C.background },
                CmpItemKindEnum = { bg = C.type, fg = C.background },
                CmpItemKindEnumMember = { bg = C.constant, fg = C.background },
                CmpItemKindEvent = { bg = C.type, fg = C.background },
                CmpItemKindField = { bg = C.func, fg = C.background },
                CmpItemKindFile = { bg = C.color4, fg = C.background },
                CmpItemKindFolder = { bg = C.color4, fg = C.background },
                CmpItemKindFunction = { bg = C.func, fg = C.background },
                CmpItemKindInterface = { bg = C.variable, fg = C.background },
                CmpItemKindKey = { bg = C.func, fg = C.background },
                CmpItemKindKeyword = { bg = C.keyword, fg = C.background },
                CmpItemKindMacro = { bg = C.preproc, fg = C.background },
                CmpItemKindMethod = { bg = C.func, fg = C.background },
                CmpItemKindModule = { bg = C.include, fg = C.background },
                CmpItemKindNamespace = { bg = C.include, fg = C.background },
                CmpItemKindNull = { bg = C.special, fg = C.background },
                CmpItemKindNumber = { bg = C.number, fg = C.background },
                CmpItemKindObject = { bg = C.constant, fg = C.background },
                CmpItemKindOperator = { bg = C.operator, fg = C.background },
                CmpItemKindPackage = { bg = C.include, fg = C.background },
                CmpItemKindParameter = { bg = C.identifier, fg = C.background },
                CmpItemKindProperty = { bg = C.func, fg = C.background },
                CmpItemKindReference = { bg = C.tag, fg = C.background },
                CmpItemKindSnippet = { bg = C.include, fg = C.background },
                CmpItemKindStaticMethod = { bg = C.func, fg = C.background },
                CmpItemKindString = { bg = C.string, fg = C.background },
                CmpItemKindStruct = { bg = C.type, fg = C.background },
                CmpItemKindText = { bg = C.foreground, fg = C.background },
                CmpItemKindTypeAlias = { bg = C.typedef, fg = C.background },
                CmpItemKindType = { bg = C.type, fg = C.background },
                CmpItemKindTypeParameter = { bg = C.type, fg = C.background },
                CmpItemKindUnit = { bg = C.type, fg = C.background },
                CmpItemKindValue = { bg = C.string, fg = C.background },
                CmpItemKindVariable = { bg = C.variable, fg = C.background },
            }
        end,
    },
})

neopywal.load()
