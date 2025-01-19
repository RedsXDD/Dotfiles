local has_jump2d, jump2d = pcall(require, "mini.jump2d")
if not has_jump2d then return end

jump2d.setup({
    view = {
        dim = true,
        n_steps_ahead = 10000,
    },
    mappings = {
        start_jumping = "s",
    },
})
