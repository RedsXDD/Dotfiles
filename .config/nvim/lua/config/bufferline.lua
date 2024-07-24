local has_bufferline, bufferline = pcall(require, "bufferline")
if not has_bufferline then return end

bufferline.setup({
    highlights = require("neopywal.theme.plugins.bufferline").setup(),
    options = {
        numbers = "ordinal",
        buffer_close_icon = "",
        close_icon = "",
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        diagnostics = "nvim_lsp",
        separator_style = "thick", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
        diagnostics_indicator = function(_, _, diag)
            local icons = require("core.icons").diagnostics
            local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                .. (diag.warning and icons.Warn .. diag.warning .. " " or "")
                .. (diag.info and icons.Info .. diag.info .. " " or "")
                .. (diag.hint and icons.Hint .. diag.hint .. " " or "")
            return vim.trim(ret)
        end,
        offsets = {
            {
                highlight = "BufferLineFill",
                filetype = "neo-tree",
                text = "Neo-tree",
                text_align = "center",
            },
        },
    },
})
