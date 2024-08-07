local has_ai, ai = pcall(require, "mini.ai")
if not has_ai then return end

local has_extra, extra = pcall(require, "mini.extra")
if not has_extra then return end

local gen_spec = ai.gen_spec
local gen_ai_spec = extra.gen_ai_spec

ai.setup({
    n_lines = 500,
    custom_textobjects = {
        -- Treesitter:
        o = gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        d = { "%f[%d]%d+" }, -- Digits.

        -- Word with case.
        e = {
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
        },

        -- Whole buffer, similar to `gg` and 'G' motion.
        g = function()
            local from = { line = 1, col = 1 }
            local to = {
                line = vim.fn.line("$"),
                col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
        end,

        u = gen_spec.function_call(), -- u for "Usage".
        U = gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name.

        -- Mini.extra:
        B = gen_ai_spec.buffer(),
        D = gen_ai_spec.diagnostic(),
        I = gen_ai_spec.indent(),
        L = gen_ai_spec.line(),
        N = gen_ai_spec.number(),
    },
})
