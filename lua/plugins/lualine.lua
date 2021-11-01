local package = require("package-info")

local function getPackage()
  return package.get_status()
end

require("lualine").setup(
  {
    options = {theme = "tokyonight"},
    sections = {
      lualine_a = {},
      lualine_b = {"branch"},
      lualine_c = {
        {
          "filename",
          file_status = false, -- displays file status (readonly status, modified status)
          path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
        }
      },
      lualine_x = {getPackage},
      lualine_y = {"filetype"},
      lualine_z = {}
    },
    extensions = {"fugitive"}
  }
)
