local api = vim.api

local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local builtin = require("telescope.builtin")

require("telescope").setup {
  defaults = {
    layout_config = {
      horizontal = {width = 0.9}
      -- other layout configuration here
    },
    dynamic_preview_title = true
  },
  pickers = {
    buffers = {
      sort_mru = true
    }
  }
}

pickers.new {
  finder = finders.new_oneshot_job({"terraform", "show"}),
  previewer = previewers.new_termopen_previewer {
    dyn_title = function(_, entry)
      return entry.filename
    end,
    get_command = function(entry, status)
      return {"cat", entry.path}
    end
  }
}

api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {noremap = true})
-- api.nvim_set_keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", {noremap = true})
-- api.nvim_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", {noremap = true})
vim.keymap.set("n", "gd", builtin.lsp_definitions, {noremap = true, silent = true})
vim.keymap.set("n", "gr", builtin.lsp_references, {noremap = true, silent = true})
api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", {noremap = true})
api.nvim_set_keymap("n", "<leader>F", "<cmd>Telescope live_grep<cr>", {noremap = true})
api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {noremap = true})
