return {
  {
    "rcarriga/nvim-notify",
    version = "*",
    lazy = false,
    priority = 900,
    opts = function()
      local p = require("vicarious.theme.palette")
      return {
        background_colour = p.background,
        stages = "fade_in_slide_out",
        render = "compact",
        timeout = 2600,
        top_down = true,
        max_width = function()
          return math.max(40, math.floor(vim.o.columns * 0.35))
        end,
      }
    end,
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = function(message, level, options)
        options = vim.tbl_extend("keep", options or {}, { title = "VICARIOUS SYSTEM" })
        return notify(message, level, options)
      end
    end,
    keys = {
      { "<leader>un", "<cmd>Notifications<cr>", desc = "Vicarious: historico de notificacoes" },
    },
  },
}
