local has_pairs, pairs = pcall(require, "mini.pairs")
if not has_pairs then return end

local map = require("core.utils").map

map({ "n", "x" }, "<Leader>tp", function()
    local state = vim.g.minipairs_disable
    state = not state
    vim.g.minipairs_disable = state
    vim.notify(state and "Disabled " .. "mini.pairs" or "Enabled " .. "mini.pairs", vim.log.levels.INFO)
end, "Toggle Mini.pairs.")

pairs.setup({
    modes = { insert = true, command = true, terminal = false },

    -- skip autopair when next character is one of these
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],

    -- skip autopair when the cursor is inside these treesitter nodes
    skip_ts = { "string" },

    -- skip autopair when next character is closing pair
    -- and there are more closing pairs than opening pairs
    skip_unbalanced = true,

    -- better deal with markdown code blocks
    markdown = true,

    -- Global mappings. Each right hand side should be a pair information, a
    -- table with at least these fields (see more in |MiniPairs.map|):
    -- - <action> - one of 'open', 'close', 'closeopen'.
    -- - <pair> - two character string for pair to be used.
    -- By default pair is not inserted after `\`, quotes are not recognized by
    -- `<CR>`, `'` does not insert pair after a letter.
    -- Only parts of tables can be tweaked (others will use these defaults).
    mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
        ["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\].", register = { cr = false } },

        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        [">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\].", register = { cr = false } },

        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
        ["´"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\´].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
    },
})
