local M = {}

local modes = {
  n = { "COMMAND", "VicariousStatusCommand" },
  no = { "COMMAND?", "VicariousStatusCommand" },
  nov = { "COMMAND?", "VicariousStatusCommand" },
  noV = { "COMMAND?", "VicariousStatusCommand" },
  ["no\22"] = { "COMMAND?", "VicariousStatusCommand" },
  niI = { "COMMAND", "VicariousStatusCommand" },
  niR = { "COMMAND", "VicariousStatusCommand" },
  niV = { "COMMAND", "VicariousStatusCommand" },
  nt = { "COMMAND", "VicariousStatusCommand" },
  v = { "SELECT", "VicariousStatusSelect" },
  V = { "SELECT LINE", "VicariousStatusSelect" },
  ["\22"] = { "SELECT BLOCK", "VicariousStatusSelect" },
  s = { "SELECT", "VicariousStatusSelect" },
  S = { "SELECT LINE", "VicariousStatusSelect" },
  ["\19"] = { "SELECT BLOCK", "VicariousStatusSelect" },
  i = { "INPUT", "VicariousStatusInput" },
  ic = { "INPUT", "VicariousStatusInput" },
  ix = { "INPUT", "VicariousStatusInput" },
  R = { "OVERWRITE", "VicariousStatusOverwrite" },
  Rc = { "OVERWRITE", "VicariousStatusOverwrite" },
  Rx = { "OVERWRITE", "VicariousStatusOverwrite" },
  Rv = { "V-OVERWRITE", "VicariousStatusOverwrite" },
  c = { "SHELL", "VicariousStatusShell" },
  cv = { "EX", "VicariousStatusShell" },
  ce = { "EX", "VicariousStatusShell" },
  r = { "CONFIRM", "VicariousStatusShell" },
  rm = { "MORE", "VicariousStatusShell" },
  ["r?"] = { "CONFIRM", "VicariousStatusShell" },
  t = { "TERMINAL", "VicariousStatusShell" },
}

local function escape(value)
  return tostring(value or ""):gsub("%%", "%%%%")
end

local function status_buffer()
  local win = tonumber(vim.g.statusline_winid)
  if win and vim.api.nvim_win_is_valid(win) then
    return vim.api.nvim_win_get_buf(win), win
  end
  return vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win()
end

local function diagnostics(buf)
  local counts = { 0, 0, 0, 0 }
  for _, item in ipairs(vim.diagnostic.get(buf)) do
    if item.severity and counts[item.severity] then
      counts[item.severity] = counts[item.severity] + 1
    end
  end

  local parts = {}
  if counts[vim.diagnostic.severity.ERROR] > 0 then
    table.insert(parts, "%#DiagnosticError#E:" .. counts[vim.diagnostic.severity.ERROR])
  end
  if counts[vim.diagnostic.severity.WARN] > 0 then
    table.insert(parts, "%#DiagnosticWarn#W:" .. counts[vim.diagnostic.severity.WARN])
  end
  if counts[vim.diagnostic.severity.INFO] > 0 then
    table.insert(parts, "%#DiagnosticInfo#I:" .. counts[vim.diagnostic.severity.INFO])
  end
  if counts[vim.diagnostic.severity.HINT] > 0 then
    table.insert(parts, "%#DiagnosticHint#H:" .. counts[vim.diagnostic.severity.HINT])
  end
  return table.concat(parts, " ")
end

local function lsp_name(buf)
  local ok, clients = pcall(vim.lsp.get_clients, { bufnr = buf })
  if not ok or #clients == 0 then
    return "LSP OFFLINE"
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name:upper())
  end
  return "LSP " .. table.concat(names, "+")
end

local function ai_segment()
  if not package.loaded["sidekick.status"] then
    return ""
  end

  local ok, sessions = pcall(function()
    return require("sidekick.status").cli()
  end)
  if not ok or type(sessions) ~= "table" or #sessions == 0 then
    return ""
  end

  local count = #sessions > 1 and (" " .. #sessions) or ""
  return "%#VicariousStatusAi# AI" .. count .. " "
end

function M.render()
  local buf, win = status_buffer()
  local active = win == vim.api.nvim_get_current_win()
  local ft = vim.bo[buf].filetype

  if ft == "vicarious_dashboard" then
    return "%#VicariousStatusCommand# VICARIOUS HOME %*%#VicariousStatusSection# BUILD "
      .. vim.g.vicarious_build
      .. " %= SYSTEM READY · "
      .. os.date("%H:%M")
      .. " "
  end

  local current_mode = modes[vim.api.nvim_get_mode().mode] or { "UNKNOWN", "VicariousStatusInactive" }
  if not active then
    current_mode = { "INACTIVE", "VicariousStatusInactive" }
  end

  local name = vim.api.nvim_buf_get_name(buf)
  name = name == "" and "[SCRATCH]" or vim.fn.fnamemodify(name, ":t")
  if vim.bo[buf].modified then
    name = name .. " [+]"
  end
  if vim.bo[buf].readonly then
    name = name .. " [RO]"
  end

  local branch = vim.b[buf].gitsigns_head
  local branch_segment = branch and branch ~= "" and ("  %#VicariousStatusGit# " .. escape(branch)) or ""
  local diagnostic_segment = diagnostics(buf)
  if diagnostic_segment ~= "" then
    diagnostic_segment = "  " .. diagnostic_segment
  end

  local study = require("vicarious.study").segment()
  local study_segment = study ~= "" and ("%#VicariousStatusStudy#" .. escape(study)) or ""
  local filetype = ft ~= "" and ft:upper() or "TEXT"

  return table.concat({
    "%#" .. current_mode[2] .. "# " .. current_mode[1] .. " ",
    "%#VicariousStatusFile#  " .. escape(name),
    branch_segment,
    diagnostic_segment,
    "%=",
    ai_segment(),
    study_segment,
    "%#VicariousStatusLsp# " .. escape(lsp_name(buf)) .. " ",
    "%#VicariousStatusSection# " .. escape(filetype) .. " · %l:%c · " .. os.date("%H:%M") .. " ",
  })
end

function M.setup()
  vim.o.statusline = "%!v:lua.require('vicarious.ui.statusline').render()"
end

return M
