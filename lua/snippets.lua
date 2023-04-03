local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local types = require("luasnip.util.types")

-- Every unspecified option will be set to the default.
ls.config.set_config(
  {
    history = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI"
  }
)

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
  return args[1]
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls
rec_ls = function()
  return sn(
    nil,
    c(
      1,
      {
        -- Order is important, sn(...) first would cause infinite loop of expansion.
        t(""),
        sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})})
      }
    )
  )
end

-- complicated function for dynamicNode.
local function jdocsnip(args, old_state)
  local nodes = {
    t({"/**", " * "}),
    i(1, "A short Description"),
    t({"", ""})
  }

  -- These will be merged with the snippet; that way, should the snippet be updated,
  -- some user input eg. text can be referred to in the new snippet.
  local param_nodes = {}

  if old_state then
    nodes[2] = i(1, old_state.descr:get_text())
  end
  param_nodes.descr = nodes[2]

  -- At least one param.
  if string.find(args[2][1], ", ") then
    vim.list_extend(nodes, {t({" * ", ""})})
  end

  local insert = 2
  for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
    -- Get actual name parameter.
    arg = vim.split(arg, " ", true)[2]
    if arg then
      local inode
      -- if there was some text in this parameter, use it as static_text for this new snippet.
      if old_state and old_state[arg] then
        inode = i(insert, old_state["arg" .. arg]:get_text())
      else
        inode = i(insert)
      end
      vim.list_extend(nodes, {t({" * @param " .. arg .. " "}), inode, t({"", ""})})
      param_nodes["arg" .. arg] = inode

      insert = insert + 1
    end
  end

  if args[1][1] ~= "void" then
    local inode
    if old_state and old_state.ret then
      inode = i(insert, old_state.ret:get_text())
    else
      inode = i(insert)
    end

    vim.list_extend(nodes, {t({" * ", " * @return "}), inode, t({"", ""})})
    param_nodes.ret = inode
    insert = insert + 1
  end

  if vim.tbl_count(args[3]) ~= 1 then
    local exc = string.gsub(args[3][2], " throws ", "")
    local ins
    if old_state and old_state.ex then
      ins = i(insert, old_state.ex:get_text())
    else
      ins = i(insert)
    end
    vim.list_extend(nodes, {t({" * ", " * @throws " .. exc .. " "}), ins, t({"", ""})})
    param_nodes.ex = ins
    insert = insert + 1
  end

  vim.list_extend(nodes, {t({" */"})})

  local snip = sn(nil, nodes)
  -- Error on attempting overwrite.
  snip.old_state = param_nodes
  return snip
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, command)
  local file = io.popen(command, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
  local fmt = fmt or "%Y-%m-%d"
  return sn(nil, i(1, os.date(fmt)))
end

ls.snippets = {
  javascript = {
    s(
      {trig = "sty", name = "emotion styled component", dscr = "description"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled."),
        i(2, "div"),
        t({"`", "\t"}),
        i(3),
        t({"", "`"})
      }
    ),
    s(
      {trig = "stf", name = "emotion styled component function", dscr = "uses the function version"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled("),
        i(2, "ExtendedComponent"),
        t({")`", "\t"}),
        i(3),
        t({"", "`"})
      }
    )
  },
  typescriptreact = {
    s(
      {trig = "sty", name = "emotion styled component", dscr = "description"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled."),
        i(2, "div"),
        t({"`", "\t"}),
        i(3),
        t({"", "`"})
      }
    ),
    s(
      {trig = "stf", name = "emotion styled component function", dscr = "uses the function version"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled("),
        i(2, "ExtendedComponent"),
        t({")`", "\t"}),
        i(3),
        t({"", "`"})
      }
    ),
    s(
      {trig = "rfc", name = "typescript react component"},
      {
        t({"import styled from '@emotion/styled'", "", ""}),
        t("const "),
        f(
          function(args, snip)
            return snip.env.TM_FILENAME_BASE
          end,
          {}
        ),
        t(" = () => {"),
        t(
          {
            "",
            "",
            "\treturn (",
            "\t\t<Root><div>"
          }
        ),
        f(
          function(args, snip)
            return snip.env.TM_FILENAME_BASE
          end,
          {}
        ),
        t(
          {
            "</div></Root>",
            "\t)",
            "}",
            "",
            "const Root = styled.div``",
            "",
            "export default "
          }
        ),
        f(
          function(args, snip)
            return snip.env.TM_FILENAME_BASE
          end,
          {}
        )
      }
    )
  }
}

ls.add_snippets(
  "typescript",
  {
    s(
      {trig = "rh", name = "typescript react hook"},
      {
        t("export const "),
        f(
          function(args, snip)
            return snip.env.TM_FILENAME_BASE
          end,
          {}
        ),
        t(
          {
            " = () => {",
            "\tconsole.log()",
            "}"
          }
        )
      }
    )
  }
)

-- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
ls.add_snippets(
  "typescriptreact",
  {
    s(
      {trig = "sty", name = "emotion styled component", dscr = "description"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled."),
        i(2, "div"),
        t({"`", "\t"}),
        i(3),
        t({"", "`"})
      }
    ),
    s(
      {trig = "stf", name = "emotion styled component function", dscr = "uses the function version"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled("),
        i(2, "ExtendedComponent"),
        t({")`", "\t"}),
        i(3),
        t({"", "`"})
      }
    ),
    s(
      {trig = "rfc", name = "typescript react component"},
      {
        t({"import styled from '@emotion/styled'", "", ""}),
        t("const "),
        f(
          function(args, snip)
            return snip.env.TM_FILENAME_BASE
          end,
          {}
        ),
        t(" = () => {"),
        t(
          {
            "",
            "",
            "\treturn (",
            "\t\t<Root><div>"
          }
        ),
        f(
          function(args, snip)
            return snip.env.TM_FILENAME_BASE
          end,
          {}
        ),
        t(
          {
            "</div></Root>",
            "\t)",
            "}",
            "",
            "const Root = styled.div``",
            "",
            "export default "
          }
        ),
        f(
          function(args, snip)
            return snip.env.TM_FILENAME_BASE
          end,
          {}
        )
      }
    ),
    s(
      {trig = "rh", name = "typescript react hook"},
      {
        t("export const "),
        f(
          function(args, snip)
            return snip.env.TM_FILENAME_BASE
          end,
          {}
        ),
        t(" = () => {"),
        t(
          {
            "console.log()",
            "}"
          }
        )
      }
    )
  }
)
ls.autosnippets = {
  javascript = {
    s(
      {trig = "sty", name = "emotion styled component", dscr = "description"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled."),
        i(2, "div"),
        t({"`", "\t"}),
        i(3),
        t({"", "`"})
      }
    ),
    s(
      {trig = "stf", name = "emotion styled component function", dscr = "uses the function version"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled("),
        i(2, "ExtendedComponent"),
        t({")`", "\t"}),
        i(3),
        t({"", "`"})
      }
    )
  },
  typescriptreact = {
    s(
      {trig = "sty", name = "emotion styled component", dscr = "description"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled."),
        i(2, "div"),
        t({"`", "\t"}),
        i(3),
        t({"", "`"})
      }
    ),
    s(
      {trig = "stf", name = "emotion styled component function", dscr = "uses the function version"},
      {
        t("const "),
        i(1, "Component"),
        t(" = styled("),
        i(2, "ExtendedComponent"),
        t({")`", "\t"}),
        i(3),
        t({"", "`"})
      }
    )
  }
}

-- in a lua file: search lua-, then c-, then all-snippets.
ls.filetype_extend("typescriptreact", {"typescript", "javascript"})
ls.filetype_extend("typescript", {"javascript"})
-- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
-- ls.filetype_set("cpp", {"c"})

--[[
-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.
]]
-- require("luasnip.loaders.from_vscode").load {}
-- require("luasnip/loaders/from_vscode").load({include = {"typescriptreact"}}) -- Load only python snippets
-- The directories will have to be structured like eg. <https://github.com/rafamadriz/friendly-snippets> (include
-- a similar `package.json`)
require("luasnip/loaders/from_vscode").load {}
require("luasnip/loaders/from_vscode").lazy_load {paths = {"~/.config/lua/my-snippets"}} -- Load snippets from my-snippets folder

-- You can also use lazy loading so you only get in memory snippets of languages you use
-- require("luasnip/loaders/from_vscode").lazy_load({paths = "./my-snippets/*"}) -- You can pass { paths = "./my-snippets/"} as well
