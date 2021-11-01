local fn = vim.fn
local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require("lspkind") -- this may mess up formatting

local feedkey = function(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  completion = {
    completeopt = "menu,menuone,noselect"
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

      -- set a name for each source
      vim_item.menu =
        ({
        luasnip = "[LuaSnip]",
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]"
      })[entry.source.name]

      return vim_item
    end
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if vim.fn.pumvisible() == 1 then
          feedkey("<C-n>")
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end,
      {"i", "s"}
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        if vim.fn.pumvisible() == 1 then
          feedkey("<C-p>")
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      {"i", "s"}
    )
  },
  sources = {
    {name = "luasnip"},
    {name = "nvim_lsp"},
    {name = "nvim_lua"},
    {name = "buffer"},
    {name = "path"}
  }
}
