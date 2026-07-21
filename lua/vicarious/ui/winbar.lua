local M = {}

local ignored = {
  vicarious_dashboard = true,
  neo_tree = true,
  lazy = true,
  mason = true,
  notify = true,
  terminal = true,
  help = true,
  qf = true,
}

function M.render()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)
  local ft = vim.bo[buf].filetype
  local buftype = vim.bo[buf].buftype
  if ignored[ft] or (buftype ~= "" and buftype ~= "acwrite") then
    return ""
  end

  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return "%#VicariousWinbarPrefix# VICARIOUS://%#VicariousWinbarPath#SCRATCH "
  end

  local relative = vim.fn.fnamemodify(name, ":~:.")
  relative = relative:gsub("%%", "%%%%"):gsub("/", " %#VicariousWinbarPrefix#›%#VicariousWinbarPath# ")
  local modified = vim.bo[buf].modified and "%#VicariousWinbarModified# ●" or ""
  return "%#VicariousWinbarPrefix# VICARIOUS:// %#VicariousWinbarPath#" .. relative .. modified .. " "
end

function M.setup()
  vim.o.winbar = "%!v:lua.require('vicarious.ui.winbar').render()"
end

return M
