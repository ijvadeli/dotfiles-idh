-- Basic editor settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.ignorecase = true
-- Colorscheme
vim.cmd.colorscheme('catppuccin')
-- Transparency
vim.cmd [[
	highlight Normal guibg=NONE
	highlight NonText guibg=NONE
	highlight NormalNC guibg=NONE
	highlight TabLine guibg=NONE
]]
