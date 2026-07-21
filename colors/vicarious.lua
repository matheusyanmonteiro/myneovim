vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "vicarious"

require("vicarious.theme.highlights").apply()

local p = require("vicarious.theme.palette")
local terminal_colors = {
  p.background,
  p.red,
  p.green,
  p.yellow,
  p.blue,
  p.magenta,
  p.cyan,
  p.foreground,
  p.muted,
  p.red,
  p.terminal,
  p.orange,
  p.blue,
  p.magenta,
  p.cyan,
  p.cursor,
}

for index, color in ipairs(terminal_colors) do
  vim.g["terminal_color_" .. (index - 1)] = color
end
