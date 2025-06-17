---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'palenight',
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  -- akjsdbnajcbali
  changed_themes = {
    palenight = {
      base_30 = {
        grey_fg = "#797985",
      },
      base_16 = {
        base03 = "#797985",
      }
    }
  }
}
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")



return M
