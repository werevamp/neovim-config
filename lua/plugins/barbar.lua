local api = vim.api

vim.cmd [[
  nnoremap <silent>    <A-,> :BufferPrevious<CR>
  nnoremap <silent>    <A-.> :BufferNext<CR>
  " Re-order to previous/next
  nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
  nnoremap <silent>    <A->> :BufferMoveNext<CR>
  " Goto buffer in position...
  nnoremap <silent>    <A-1> :BufferGoto 1<CR>
  nnoremap <silent>    <A-2> :BufferGoto 2<CR>
  nnoremap <silent>    <A-3> :BufferGoto 3<CR>
  nnoremap <silent>    <A-4> :BufferGoto 4<CR>
  nnoremap <silent>    <A-5> :BufferGoto 5<CR>
  nnoremap <silent>    <A-6> :BufferGoto 6<CR>
  nnoremap <silent>    <A-7> :BufferGoto 7<CR>
  nnoremap <silent>    <A-8> :BufferGoto 8<CR>
  nnoremap <silent>    <A-9> :BufferLast<CR>
  " Close buffer
  nnoremap <silent>    <A-c> :BufferClose<CR>
  " Wipeout buffer
  "                          :BufferWipeout<CR>
  " Close commands
  "                          :BufferCloseAllButCurrent<CR>
  "                          :BufferCloseBuffersLeft<CR>
  "                          :BufferCloseBuffersRight<CR>
  " Magic buffer-picking mode
  nnoremap <silent> <C-s>    :BufferPick<CR>
  " Sort automatically by...
  nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
  nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
  let bufferline = get(g:, 'bufferline', {})
  let bufferline.maximum_length = 100
]]

api.nvim_set_keymap("n", "<Leader>d", ":BufferClose<cr>", {noremap = true})
api.nvim_set_keymap("n", "<C-j>", ":BufferPrevious<cr>", {noremap = true})
api.nvim_set_keymap("n", "<C-k>", ":BufferNext<cr>", {noremap = true})

api.nvim_set_keymap("n", "<S-Left>", ":BufferMovePrevious<cr>", {noremap = true})
api.nvim_set_keymap("n", "<S-Right>", ":BufferMoveNext<cr>", {noremap = true})
