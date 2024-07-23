local has_alpha, alpha = pcall(require, "alpha")
if not has_alpha then return end

local dashboard = require("alpha.themes.dashboard")
local startpage = require("core.startpage")

-- Footer.
vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("autocmd_refresh_alpha", { clear = true }),
    callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = startpage.icons.footer
            .. "Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
        pcall(vim.cmd.AlphaRedraw)
    end,
})

dashboard.section.header.val = startpage.alpha.header
dashboard.section.buttons.val = startpage.alpha.sections

-- Set dashboard highlight colors.
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

-- Main options.
dashboard.opts.layout[1].val = startpage.top_padding
dashboard.config.opts.margin = 0
dashboard.config.opts.noautocmd = true

alpha.setup(dashboard.config)
