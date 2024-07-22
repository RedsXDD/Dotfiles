local has_jump, jump = pcall(require, "mini.jump")
if not has_jump then
	return
end

jump.setup({ delay = { highlight = 0 } })
