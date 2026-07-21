local M = {}

local logo = {
  "██╗   ██╗██╗ ██████╗ █████╗ ██████╗ ██╗ ██████╗ ██╗   ██╗███████╗",
  "██║   ██║██║██╔════╝██╔══██╗██╔══██╗██║██╔═══██╗██║   ██║██╔════╝",
  "██║   ██║██║██║     ███████║██████╔╝██║██║   ██║██║   ██║███████╗",
  "╚██╗ ██╔╝██║██║     ██╔══██║██╔══██╗██║██║   ██║██║   ██║╚════██║",
  " ╚████╔╝ ██║╚██████╗██║  ██║██║  ██║██║╚██████╔╝╚██████╔╝███████║",
  "  ╚═══╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝  ╚═════╝ ╚══════╝",
}

local compact_logo = {
  "╔══════════════════════════════════════╗",
  "║       V I C A R I O U S . N V I M  ║",
  "╚══════════════════════════════════════╝",
}

-- Arte escolhida pelo usuario. Os sublinhados vieram do desenho original como
-- espacos; a normalizacao abaixo os transforma em fundo transparente.
local wolf_source = [[
____11________________1___________________________
___¶¶¶¶_____________¶¶¶¶__________________________
___¶¶_¶¶¶1_______1¶¶¶1¶¶__________________________
___¶¶**¶¶¶¶¶¶¶¶¶¶¶¶¶**¶¶__________________________
___¶¶*1¶¶¶¶¶¶¶¶¶¶¶¶¶1*¶¶__________________________
____1¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶__________________________
____¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶___________________________
____¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶___________________________
____¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶__________________________
_____¶¶¶11¶¶¶¶¶¶¶¶¶¶_¶¶¶__________________________
____¶¶*¶1\_\_\_¶¶¶¶¶\_\_1¶1*¶¶¶________________________
____¶¶__1¶¶11¶¶¶¶1¶¶___1¶¶¶1______________________
____¶¶_____¶¶¶¶¶¶¶1____1¶¶¶¶¶¶1___________________
____¶¶_______11_¶______¶¶¶¶¶¶¶¶¶__________________
____1¶1_______________¶¶¶¶¶¶¶¶¶¶¶¶________________
_____¶¶_______________¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶_____________
______1¶_____________¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶1___________
_______1¶1_______11_¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶__________
_________¶1_____¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶_________
_________¶¶__¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶1________
_________¶1_¶¶1¶¶¶¶__¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶________
_________¶1_¶¶1¶¶¶¶¶1_¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶1______
________¶¶¶*¶1¶¶¶¶¶*¶¶_¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶1______
________¶¶¶*¶*¶¶¶¶¶1_¶¶_1¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶1_____
________¶¶¶*¶*¶¶¶¶¶1__11_1¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶_____
________1¶¶*¶*¶¶¶¶¶_¶¶¶¶¶¶¶¶11¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶____
_______¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶1¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶____
_______¶¶¶¶¶1¶¶¶¶¶1¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶1_¶¶¶¶¶¶____
_____________________________________¶¶¶¶¶¶¶¶¶____
______________________¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶_____
___________________¶¶¶1¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶______
_________________¶¶1__1¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶_________
_________________1¶¶11¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶1____________
____________________1¶¶¶¶¶¶¶¶¶1___________________
]]

local wolf = {}
for line in wolf_source:gmatch("[^\r\n]+") do
  local normalized = line:gsub("\\", ""):gsub("¶", "1"):gsub("_", " "):gsub("%s+$", "")
  table.insert(wolf, normalized)
end

-- Braille representa blocos de 2x4 caracteres. A silhueta compacta continua
-- vindo da mesma arte, em vez de usar um segundo desenho diferente.
local function compact_braille(lines)
  local result = {}
  local max_width = 0
  for _, line in ipairs(lines) do
    max_width = math.max(max_width, #line)
  end
  local dots = {
    { 1, 8 },
    { 2, 16 },
    { 4, 32 },
    { 64, 128 },
  }

  for row = 1, #lines, 4 do
    local output = {}
    for column = 1, max_width, 2 do
      local value = 0
      for dy = 0, 3 do
        local source = lines[row + dy] or ""
        for dx = 0, 1 do
          if source:sub(column + dx, column + dx):match("%S") then
            value = value + dots[dy + 1][dx + 1]
          end
        end
      end
      table.insert(output, vim.fn.nr2char(0x2800 + value))
    end
    table.insert(result, (table.concat(output):gsub("⠀+$", "")))
  end
  return result
end

local compact_wolf = compact_braille(wolf)

local phrases = {
  "BUILD KNOWLEDGE. SHIP SYSTEMS.",
  "THE EDITOR IS A MACHINE FOR THINKING.",
  "ONE MODULE. ONE IDEA. ONE STEP FORWARD.",
  "STAY CURIOUS // KEEP BUILDING.",
  "SOURCE OPEN. MIND OPEN.",
}

local buttons = {
  { key = "n", label = "NEW BUFFER", action = "new" },
  { key = "f", label = "FIND FILE", action = "files" },
  { key = "r", label = "RECENT FILES", action = "recent" },
  { key = "p", label = "PROJECT DATABASE", action = "projects" },
  { key = "s", label = "STUDY SESSION", action = "study" },
  { key = "q", label = "SHUTDOWN", action = "quit" },
}

local function center(text, width)
  local length = vim.fn.strdisplaywidth(text)
  return string.rep(" ", math.max(0, math.floor((width - length) / 2))) .. text
end

local function plugin_stats()
  local ok, config = pcall(require, "lazy.core.config")
  if not ok then
    return 0, 0
  end
  local total, loaded = 0, 0
  for _, plugin in pairs(config.plugins) do
    total = total + 1
    if plugin._.loaded then
      loaded = loaded + 1
    end
  end
  return loaded, total
end

local function close_dashboard()
  if vim.bo.filetype == "vicarious_dashboard" then
    vim.cmd("enew")
  end
end

local actions = {
  new = close_dashboard,
  files = function()
    close_dashboard()
    require("telescope.builtin").find_files({ hidden = true, prompt_title = " VICARIOUS // FILE INDEX " })
  end,
  recent = function()
    close_dashboard()
    require("telescope.builtin").oldfiles({ prompt_title = " VICARIOUS // RECENT MEMORY " })
  end,
  projects = function()
    close_dashboard()
    require("telescope.builtin").find_files({
      cwd = vim.fn.getcwd(),
      hidden = true,
      prompt_title = " VICARIOUS // PROJECT DATABASE ",
    })
  end,
  study = function()
    close_dashboard()
    require("vicarious.study").toggle()
  end,
  quit = function()
    vim.cmd("qa")
  end,
}

local function render(buf, win)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
    return
  end

  local width = vim.api.nvim_win_get_width(win)
  local height = vim.api.nvim_win_get_height(win)
  local selected_logo = width >= 78 and logo or compact_logo
  local button_columns = width >= 64
  local button_rows = button_columns and math.ceil(#buttons / 2) or #buttons
  local full_art_height = #wolf + #selected_logo + button_rows + 3
  local selected_wolf = height >= full_art_height and width >= 58 and wolf or compact_wolf
  local show_footer = height >= 25
  local loaded, total = plugin_stats()
  local phrase = width >= 72 and phrases[(tonumber(os.date("%j")) % #phrases) + 1] or "SYSTEM READY"
  local content = {}
  local highlights = {}
  local key_highlights = {}
  local eye_highlights = {}
  local fang_highlights = {}

  local function add(text, group)
    local line = center(text or "", width)
    table.insert(content, line)
    if group then
      table.insert(highlights, { #content - 1, group })
    end
    return line, #content - 1
  end

  local core_height = #selected_wolf + #selected_logo + button_rows + 3 + (show_footer and 1 or 0)
  local show_header = height >= core_height + 2
  local body_height = core_height + (show_header and 2 or 0)
  local spare_lines = math.max(0, height - body_height)
  for _ = 1, math.max(0, math.floor((height - body_height) / 2)) do
    add("")
    spare_lines = spare_lines - 1
  end

  if show_header then
    add("01010100  SYSTEM LINK ESTABLISHED  00110110", "VicariousDashboardCircuit")
    add("┌─[ MATHEUS YAN MONTEIRO // PERSONAL DEVELOPMENT SYSTEM ]─┐", "VicariousDashboardAccent")
  end

  local common_indent = math.huge
  for _, art_line in ipairs(selected_wolf) do
    common_indent = math.min(common_indent, #(art_line:match("^%s*") or ""))
  end
  local normalized_wolf = {}
  local wolf_width = 0
  for _, art_line in ipairs(selected_wolf) do
    local normalized = art_line:sub(common_indent + 1)
    table.insert(normalized_wolf, normalized)
    wolf_width = math.max(wolf_width, vim.fn.strdisplaywidth(normalized))
  end
  local wolf_padding = string.rep(" ", math.max(0, math.floor((width - wolf_width) / 2)))

  for _, art_line in ipairs(normalized_wolf) do
    local rendered = wolf_padding .. art_line
    table.insert(content, rendered)
    local line_number = #content - 1
    table.insert(highlights, { line_number, "VicariousDashboardWolf" })
    local cursor = 1
    while true do
      local position = rendered:find("*", cursor, true)
      if not position then
        break
      end
      table.insert(eye_highlights, { line_number, position - 1, position })
      cursor = position + 1
    end
    cursor = 1
    while true do
      local position = rendered:find("V", cursor, true)
      if not position then
        break
      end
      table.insert(fang_highlights, { line_number, position - 1, position })
      cursor = position + 1
    end
  end

  if spare_lines > 0 then
    add("")
    spare_lines = spare_lines - 1
  end
  for _, line in ipairs(selected_logo) do
    add(line, "VicariousDashboardLogo")
  end
  add("BUILD " .. vim.g.vicarious_build .. "  //  " .. phrase, "VicariousDashboardTitle")
  add("────────────────────────────────────────────────", "VicariousDashboardCircuit")

  if spare_lines > 0 then
    add("")
    spare_lines = spare_lines - 1
  end

  if button_columns then
    for index = 1, #buttons, 2 do
      local left = buttons[index]
      local right = buttons[index + 1]
      local left_text = string.format("[ %s ] %-20s", left.key:upper(), left.label)
      local right_text = right and string.format("[ %s ] %-20s", right.key:upper(), right.label) or ""
      local rendered, line_number = add(left_text .. "   " .. right_text, "VicariousDashboardButton")
      for _, button in ipairs({ left, right }) do
        if button then
          local token = "[ " .. button.key:upper() .. " ]"
          local token_start = rendered:find(token, 1, true)
          if token_start then
            table.insert(key_highlights, { line_number, token_start + 1, token_start + 2 })
          end
        end
      end
    end
  else
    for _, button in ipairs(buttons) do
      local text = string.format("[ %s ]  %-20s", button.key:upper(), button.label)
      local rendered, line_number = add(text, "VicariousDashboardButton")
      local key_start = rendered:find(button.key:upper(), 1, true)
      if key_start then
        table.insert(key_highlights, { line_number, key_start - 1, key_start })
      end
    end
  end

  add(string.format("PLUGINS %02d/%02d ONLINE  ·  %s  ·  %s", loaded, total, os.date("%d.%m.%Y"), os.date("%H:%M")), "VicariousDashboardMuted")
  if show_footer then
    add("<Space>? SHORTCUT MATRIX  //  :help user-manual", "VicariousDashboardFooter")
  end

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
  vim.bo[buf].modifiable = false
  vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
  for _, item in ipairs(highlights) do
    vim.api.nvim_buf_add_highlight(buf, -1, item[2], item[1], 0, -1)
  end
  for _, item in ipairs(key_highlights) do
    vim.api.nvim_buf_add_highlight(buf, -1, "VicariousDashboardKey", item[1], item[2], item[3])
  end
  for _, item in ipairs(eye_highlights) do
    vim.api.nvim_buf_add_highlight(buf, -1, "VicariousDashboardWolfEye", item[1], item[2], item[3])
  end
  for _, item in ipairs(fang_highlights) do
    vim.api.nvim_buf_add_highlight(buf, -1, "VicariousDashboardWolfFang", item[1], item[2], item[3])
  end
end

function M.open()
  local current = vim.api.nvim_get_current_buf()
  if vim.bo[current].modified then
    return
  end

  vim.cmd("enew")
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_buf_set_name(buf, "vicarious://dashboard")
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "vicarious_dashboard"

  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].cursorline = false
  vim.wo[win].cursorcolumn = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].foldcolumn = "0"
  vim.wo[win].list = false
  vim.wo[win].spell = false
  vim.wo[win].winbar = ""

  for _, button in ipairs(buttons) do
    vim.keymap.set("n", button.key, actions[button.action], {
      buffer = buf,
      nowait = true,
      silent = true,
      desc = "Dashboard: " .. button.label,
    })
  end

  vim.keymap.set("n", "<Esc>", "<Nop>", { buffer = buf, silent = true })
  vim.api.nvim_win_set_cursor(win, { 1, 0 })
  render(buf, win)

  local group = vim.api.nvim_create_augroup("VicariousDashboardBuffer", { clear = true })
  vim.api.nvim_create_autocmd("VimResized", {
    group = group,
    callback = function()
      if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_win_is_valid(win) then
        render(buf, win)
      end
    end,
  })
end

function M.setup()
  vim.api.nvim_create_user_command("VicariousDashboard", M.open, {
    desc = "Abrir o painel inicial VICARIOUS",
  })
  vim.keymap.set("n", "<leader>ud", M.open, { desc = "Vicarious: abrir dashboard" })

  local group = vim.api.nvim_create_augroup("VicariousDashboard", { clear = true })
  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    once = true,
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local empty = vim.api.nvim_buf_get_name(buf) == ""
        and vim.api.nvim_buf_line_count(buf) == 1
        and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
      if vim.fn.argc() == 0 and empty then
        M.open()
      end
    end,
  })
end

return M
