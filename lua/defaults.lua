local vim = vim
local api = vim.api

vim.o.ruler = true
vim.o.linespace = 0
vim.o.number = true
vim.o.title = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.colorcolumn = "101"
vim.o.wildmode = "list:longest,full"
vim.cmd [[set noswapfile]]
vim.o.completeopt = "menuone,noselect"
vim.o.inccommand = "nosplit"
vim.cmd [[set shortmess+=c]]

-- Colorscheme
vim.cmd [[set termguicolors]]

function _G.my_test()
  print(vim.inspect("hello"))
end

vim.api.nvim_set_keymap("n", "<F6>", "v:lua.may_test()", {noremap = true})

api.nvim_command [[colorscheme tokyonight]]
-- api.nvim_command [[colorscheme everforest]]

vim.o.scrolloff = 8
vim.o.clipboard = "unnamedplus"

-- Indent
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.copyindent = true

-- Autorefresh
vim.o.autoread = true
vim.cmd [[au FocusGained * :checktime]]

-- Search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
