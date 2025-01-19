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
        blink_cmp = true,
        lazy = true,
        lsp = true,
        mason = true,
        noice = true,
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
            jump = true,
            jump2d = true,
            statusline = true,
            surround = true,
            tabline = true,
        },
    },
    custom_highlights = {
        all = function(C)
            return {
                BlinkCmpKindArray = { bg = C.special, fg = C.background },
                BlinkCmpKindBoolean = { bg = C.boolean, fg = C.background },
                BlinkCmpKindClass = { bg = C.type, fg = C.background },
                BlinkCmpKindColor = { bg = C.constant, fg = C.background },
                BlinkCmpKindConstant = { bg = C.constant, fg = C.background },
                BlinkCmpKindConstructor = { bg = C.special, fg = C.background },
                BlinkCmpKindEnum = { bg = C.type, fg = C.background },
                BlinkCmpKindEnumMember = { bg = C.constant, fg = C.background },
                BlinkCmpKindEvent = { bg = C.type, fg = C.background },
                BlinkCmpKindField = { bg = C.func, fg = C.background },
                BlinkCmpKindFile = { bg = C.color4, fg = C.background },
                BlinkCmpKindFolder = { bg = C.color4, fg = C.background },
                BlinkCmpKindFunction = { bg = C.func, fg = C.background },
                BlinkCmpKindInterface = { bg = C.variable, fg = C.background },
                BlinkCmpKindKey = { bg = C.func, fg = C.background },
                BlinkCmpKindKeyword = { bg = C.keyword, fg = C.background },
                BlinkCmpKindMacro = { bg = C.preproc, fg = C.background },
                BlinkCmpKindMethod = { bg = C.func, fg = C.background },
                BlinkCmpKindModule = { bg = C.include, fg = C.background },
                BlinkCmpKindNamespace = { bg = C.include, fg = C.background },
                BlinkCmpKindNull = { bg = C.special, fg = C.background },
                BlinkCmpKindNumber = { bg = C.number, fg = C.background },
                BlinkCmpKindObject = { bg = C.constant, fg = C.background },
                BlinkCmpKindOperator = { bg = C.operator, fg = C.background },
                BlinkCmpKindPackage = { bg = C.include, fg = C.background },
                BlinkCmpKindParameter = { bg = C.identifier, fg = C.background },
                BlinkCmpKindProperty = { bg = C.func, fg = C.background },
                BlinkCmpKindReference = { bg = C.tag, fg = C.background },
                BlinkCmpKindSnippet = { bg = C.include, fg = C.background },
                BlinkCmpKindStaticMethod = { bg = C.func, fg = C.background },
                BlinkCmpKindString = { bg = C.string, fg = C.background },
                BlinkCmpKindStruct = { bg = C.type, fg = C.background },
                BlinkCmpKindText = { bg = C.foreground, fg = C.background },
                BlinkCmpKindTypeAlias = { bg = C.typedef, fg = C.background },
                BlinkCmpKindType = { bg = C.type, fg = C.background },
                BlinkCmpKindTypeParameter = { bg = C.type, fg = C.background },
                BlinkCmpKindUnit = { bg = C.type, fg = C.background },
                BlinkCmpKindValue = { bg = C.string, fg = C.background },
                BlinkCmpKindVariable = { bg = C.variable, fg = C.background },
            }
        end,
    },
})

neopywal.load()
