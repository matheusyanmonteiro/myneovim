local M = {}

local state = {
  active = false,
  subject = nil,
  started_at = nil,
  timer = nil,
  previous_showtabline = nil,
}

local function format_time(seconds)
  seconds = math.max(0, math.floor(seconds or 0))
  return string.format("%02d:%02d:%02d", math.floor(seconds / 3600), math.floor(seconds % 3600 / 60), seconds % 60)
end

function M.elapsed()
  if not state.active or not state.started_at then
    return "00:00:00"
  end
  return format_time(os.time() - state.started_at)
end

function M.is_active()
  return state.active
end

function M.segment()
  if not state.active then
    return ""
  end
  return string.format(" STUDY %s · %s ", state.subject, M.elapsed())
end

local function begin(subject)
  if state.active then
    return
  end

  state.active = true
  state.subject = subject ~= "" and subject or "FOCUS SESSION"
  state.started_at = os.time()
  state.previous_showtabline = vim.o.showtabline
  vim.o.showtabline = 0

  state.timer = vim.uv.new_timer()
  state.timer:start(0, 1000, vim.schedule_wrap(function()
    if state.active then
      vim.cmd("redrawstatus")
    end
  end))

  pcall(vim.cmd, "Neotree close")
  vim.notify("Sessao iniciada: " .. state.subject, vim.log.levels.INFO, { title = "VICARIOUS STUDY" })
end

function M.stop()
  if not state.active then
    return
  end

  local elapsed = M.elapsed()
  local subject = state.subject
  state.active = false
  state.subject = nil
  state.started_at = nil

  if state.timer then
    state.timer:stop()
    if not state.timer:is_closing() then
      state.timer:close()
    end
    state.timer = nil
  end

  if state.previous_showtabline ~= nil then
    vim.o.showtabline = state.previous_showtabline
  end
  vim.cmd("redrawstatus")
  vim.notify(string.format("Sessao encerrada: %s em %s", subject, elapsed), vim.log.levels.INFO, {
    title = "VICARIOUS STUDY",
  })
end

function M.start(subject)
  if subject and subject ~= "" then
    begin(subject)
    return
  end

  vim.ui.input({ prompt = "[VICARIOUS::STUDY] Assunto: ", default = "FOCUS SESSION" }, function(value)
    if value then
      begin(value)
    end
  end)
end

function M.toggle(subject)
  if state.active then
    M.stop()
  else
    M.start(subject)
  end
end

function M.status()
  if state.active then
    vim.notify(string.format("%s · %s", state.subject, M.elapsed()), vim.log.levels.INFO, {
      title = "VICARIOUS STUDY",
    })
  else
    vim.notify("Nenhuma sessao ativa", vim.log.levels.INFO, { title = "VICARIOUS STUDY" })
  end
end

function M.setup()
  vim.api.nvim_create_user_command("StudyMode", function(args)
    M.toggle(args.args)
  end, { nargs = "?", desc = "Iniciar ou encerrar uma sessao de estudo" })

  vim.api.nvim_create_user_command("StudyStatus", M.status, {
    desc = "Mostrar o estado da sessao de estudo",
  })

  vim.keymap.set("n", "<leader>us", M.toggle, { desc = "Study: iniciar ou encerrar" })
  vim.keymap.set("n", "<leader>ui", M.status, { desc = "Study: mostrar estado" })

  local group = vim.api.nvim_create_augroup("VicariousStudy", { clear = true })
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      if state.timer then
        state.timer:stop()
        if not state.timer:is_closing() then
          state.timer:close()
        end
      end
    end,
  })
end

return M
