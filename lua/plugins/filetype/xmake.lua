return {
	"Mythos-404/xmake.nvim",
  event = "BufReadPost xmake.lua",
	config = true,
  dependencies = {"MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim"}
}