local vim = vim
local api = vim.api

api.nvim_set_keymap("n", "'", "`", {noremap = true})
api.nvim_set_keymap("n", "`", "'", {noremap = true})

api.nvim_set_keymap("n", ";", ":", {noremap = true})
api.nvim_set_keymap("n", ":", ";", {noremap = true})

api.nvim_set_keymap("n", "H", "^", {noremap = true})
api.nvim_set_keymap("n", "L", "g_", {noremap = true})
api.nvim_set_keymap("v", "H", "^", {noremap = true})
api.nvim_set_keymap("v", "L", "g_", {noremap = true})

api.nvim_set_keymap("n", "<tab>", "%", {noremap = true})
api.nvim_set_keymap("v", "<tab>", "%", {noremap = true})
vim.cmd [[vnoremap <tab> %]]

api.nvim_set_keymap("n", "<leader>qe", ":q!<cr>", {noremap = true})
api.nvim_set_keymap("n", "<leader>w", ":w<cr>", {noremap = true})

api.nvim_set_keymap("n", "<leader><space>", ":nohl<cr>", {noremap = true})

-- Indenting
api.nvim_set_keymap("n", ")", ">>", {noremap = true})
api.nvim_set_keymap("n", "(", "<<", {noremap = true})

-- Multiline Indent
api.nvim_set_keymap("v", ">", ">gv", {noremap = true})
api.nvim_set_keymap("v", "<", "<gv", {noremap = true})

api.nvim_set_keymap("n", "<leader><space>", ":nohl<cr>", {noremap = true})
api.nvim_set_keymap("n", "<F2>", ":e ~/.config/nvim/init.lua<cr>", {noremap = true, silent = true})

api.nvim_set_keymap("n", "<Right>", ":vertical resize +5<cr>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Left>", ":vertical resize -5<cr>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Down>", ":resize +5<cr>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Up>", ":resize -5<cr>", {noremap = true, silent = true})
