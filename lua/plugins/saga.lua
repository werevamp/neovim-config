local saga = require "lspsaga"

saga.init_lsp_saga()

vim.cmd [[
  nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>

  " scroll down hover doc or scroll in definition preview
  nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
  " scroll up hover doc
  nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

  nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
  nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

  nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
  nnoremap <silent> GD <cmd>lua require'lspsaga.provider'.preview_definition()<CR>

  nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
]]
