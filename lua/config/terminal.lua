local M = {}

local state = {
  buffer = nil,
  window = nil,
}

local function valid_buffer()
  return state.buffer ~= nil and vim.api.nvim_buf_is_valid(state.buffer)
end

local function valid_window()
  return state.window ~= nil and vim.api.nvim_win_is_valid(state.window)
end

local function process_is_running()
  if not valid_buffer() then
    return false
  end

  -- Em um buffer de terminal, 'channel' contem o id do processo conectado.
  local job_id = vim.bo[state.buffer].channel
  if job_id <= 0 then
    return false
  end

  -- -1 significa que o job ainda esta em execucao.
  return vim.fn.jobwait({ job_id }, 0)[1] == -1
end

local function hide_terminal()
  if not valid_window() then
    return
  end

  if #vim.api.nvim_list_wins() == 1 then
    -- O Neovim nao permite fechar a ultima janela. Mostra um buffer vazio nela.
    local replacement = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_win_set_buf(state.window, replacement)
  else
    vim.api.nvim_win_close(state.window, true)
  end

  state.window = nil
end

local function open_terminal()
  local height = math.max(8, math.floor(vim.o.lines * 0.30))
  vim.cmd(("botright %dsplit"):format(height))
  state.window = vim.api.nvim_get_current_win()

  if process_is_running() then
    vim.api.nvim_win_set_buf(state.window, state.buffer)
  else
    if valid_buffer() then
      vim.api.nvim_buf_delete(state.buffer, { force = true })
    end

    vim.cmd.terminal()
    state.buffer = vim.api.nvim_get_current_buf()
    -- Mantem o terminal vivo quando o split fecha, sem mistura-lo aos arquivos.
    vim.bo[state.buffer].bufhidden = "hide"
    vim.bo[state.buffer].buflisted = false
  end

  vim.wo[state.window].winfixheight = true
  vim.cmd.startinsert()
end

function M.toggle()
  if valid_window() then
    hide_terminal()
  else
    open_terminal()
  end
end

function M.setup()
  vim.api.nvim_create_user_command("TerminalToggle", M.toggle, {
    desc = "Alternar terminal inferior",
    force = true,
  })
end

return M
