local has_animate, animate = pcall(require, "mini.animate")
if not has_animate then return end

local mouse_scrolled = false -- don't use animate when scrolling with the mouse.
for _, scroll in ipairs({ "Up", "Down" }) do
    local key = "<ScrollWheel" .. scroll .. ">"
    vim.keymap.set({ "", "i" }, key, function()
        mouse_scrolled = true
        return key
    end, { expr = true })
end

local center_map = function(keys, desc)
    vim.keymap.set(
        { "n", "v" },
        keys,
        keys .. [[<Cmd>lua require("mini.animate").execute_after("scroll", "normal! zvzz")<CR>]],
        { noremap = true, silent = true, desc = "" .. desc }
    )
end

center_map("n", "Center cursor when moving to the next match during a search.")
center_map("N", "Center cursor when moving to the previous match during a search.")
center_map("G", "Center cursor when moving to the last line of buffer.")
center_map("<C-d>", "Center cursor when moving a half page down.")
center_map("<C-u>", "Center cursor when moving a half page up.")
center_map("<C-f>", "Center cursor when moving a page down.")
center_map("<C-b>", "Center cursor when moving a page up.")

animate.setup({
    resize = {
        timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
    },
    scroll = {
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
        subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
                if mouse_scrolled then
                    mouse_scrolled = false
                    return false
                end
                return total_scroll > 1
            end,
        }),
    },
})
