local M = {}

function M.setup()
  vim.g.vicarious_build = "2000.07"
  vim.cmd.colorscheme("vicarious")

  require("vicarious.study").setup()
  require("vicarious.ui.statusline").setup()
  require("vicarious.ui.winbar").setup()
  require("vicarious.ui.dashboard").setup()

  local group = vim.api.nvim_create_augroup("VicariousInterface", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    callback = function()
      require("vicarious.theme.highlights").apply_integrations()
    end,
  })
end

return M
