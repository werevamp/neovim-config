require("nvim-autopairs").setup {}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

--[[ require("nvim-autopairs.completion.cmp").setup(
  {
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
    auto_select = true, -- automatically select the first item
    insert = false, -- use insert confirm behavior instead of replace
    map_char = {
      -- modifies the function or method delimiter by filetypes
      all = "(",
      tex = "{"
    }
  }
) ]]
