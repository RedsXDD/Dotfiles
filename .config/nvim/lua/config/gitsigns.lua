local gitsigns = require("gitsigns")
local icons = require("core.icons")

gitsigns.setup({
	signs = {
		add = { text = icons.gitsigns.add },
		change = { text = icons.gitsigns.change },
		delete = { text = icons.gitsigns.delete },
		topdelete = { text = icons.gitsigns.topdelete },
		changedelete = { text = icons.gitsigns.changedelete },
		untracked = { text = icons.gitsigns.untracked },
	},
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns

		local function map(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = buffer, desc = desc })
		end

		map({ "n", "v" }, "]h", gs.next_hunk, "Next Hunk")
		map({ "n", "v" }, "[h", gs.prev_hunk, "Prev Hunk")
		map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
		map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
		map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
		map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
		map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
		map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
		map("n", "<leader>ghb", function()
			gs.blame_line({ full = true })
		end, "Blame Line")
		map("n", "<leader>ghd", gs.diffthis, "Diff This")
		map("n", "<leader>ghD", function()
			gs.diffthis("~")
		end, "Diff This ~")
		map({ "o", "x" }, "<Leader>ghi", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
	end,
})
