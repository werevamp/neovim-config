local saga = require "lspsaga"
saga.init_lsp_saga()
local map = vim.api.nvim_set_keymap

map("n", "K", "<Cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
map("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", {silent = true, noremap = true})
map("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", {silent = true, noremap = true})
vim.cmd [[
  nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
  nnoremap <silent> GD <cmd>lua require'lspsaga.provider'.preview_definition()<CR>

  nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
]]
