local vim = vim
local api = vim.api

vim.o.hidden = true
vim.g.mapleader = ","

vim.cmd [[highlight link CompeDocumentation NormalFloat]]
--[[ vim.cmd [[
  let g:python_host_prog = '/usr/local/bin/python2'
  let g:python2_host_prog = '/usr/local/bin/python'
  let g:python3_host_prog = '/usr/local/bin/python3.9'
]]
require("plugins")
require("defaults")
require("keyRemaps")

-- Plugins
require("lsp")
require("snippets")
require("plugins/treesitter")
require("plugins/completion")
require("plugins/telescope")
require("plugins/indentGuides")
require("plugins/gitGutter")
require("plugins/sneak")
require("plugins/barbar")
require("plugins/luasnip")
require("plugins/nvimCmp")
require("plugins/saga")
require("plugins/formatter")
require("plugins/gitsigns")
require("plugins/tagalong")
require("plugins/kommentary")
require("plugins/lualine")
require("plugins/autopair")
require("plugins/autotag")
require("plugins/zenMode")
require("plugins/cursorline")
require("plugins/packageInfo")
require("plugins/fugitive")
require("plugins/lspkind")
require("plugins/distant")
