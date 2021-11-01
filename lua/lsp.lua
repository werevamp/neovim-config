local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require "lsp_signature".on_attach(
    {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "single"
      }
    }
  )

  -- Mappings.
  local opts = {noremap = true, silent = true}

  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>so",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    opts
  )
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- nvim_lsp.tsserver.setup {capabilities = capabilities}
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"tsserver"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150
    },
    handlers = {
      ["textDocument/definition"] = function(_, method, result)
        if result == nil or vim.tbl_isempty(result) then
          local _ = vim.lsp.log.info() and vim.lsp.log.info(method, "No location found")
          return nil
        end

        if vim.tbl_islist(result) then
          vim.lsp.util.jump_to_location(result[1])
          if #result > 1 then
            local isReactDTs = false
            for key, value in pairs(result) do
              if string.match(value.uri, "react/index.d.ts") then
                isReactDTs = true
                break
              end
            end
            if not isReactDTs then
              vim.lsp.util.set_qflist(util.locations_to_items(result))
              vim.api.nvim_command("copen")
              vim.api.api.nvim_command("wincmd p")
            end
          end
        else
          vim.lsp.util.jump_to_location(result)
        end
      end
    }
  }
end
