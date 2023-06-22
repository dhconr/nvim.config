require("gruvbox").setup({
	italic = false, 
    transparent_mode = true, 
})
--vim.cmd("colorscheme gruvbox")

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true, 
    no_italic = true, 
})
--vim.cmd("colorscheme catppuccin")

require("onedark").setup({
    style = 'warm', 
    transparent = true, 
})
--require("onedark").load()

vim.cmd("colorscheme gruvbox")
