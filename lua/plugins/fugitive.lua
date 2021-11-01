local api = vim.api

vim.cmd [[
nnoremap <leader>2 :diffget //2<CR>
nnoremap <leader>3 :diffget //3<CR>
]]

api.nvim_set_keymap("n", "<Leader>2", ":diffget //2<cr>", {noremap = true})
api.nvim_set_keymap("n", "<Leader>3", ":diffget //3<cr>", {noremap = true})
