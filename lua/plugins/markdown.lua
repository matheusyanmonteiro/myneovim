return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    version = "*",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>mr",
        function()
          require("render-markdown").buf_toggle()
        end,
        desc = "Markdown: alternar renderizacao",
      },
      {
        "<leader>mp",
        function()
          require("render-markdown").preview()
        end,
        desc = "Markdown: pre-visualizar ao lado",
      },
    },
    opts = {
      -- O preset fornece callouts, links e realces familiares a quem usa Obsidian.
      preset = "obsidian",
      -- No modo Insercao o texto cru reaparece para continuar facil de editar.
      render_modes = { "n", "c", "t" },
      completions = {
        -- Completa estados de checkbox e callouts usando o nvim-cmp ja instalado.
        lsp = { enabled = true },
      },
      heading = {
        width = "full",
        position = "overlay",
        icons = { "󰼏  ", "󰎨  ", "󰼑  ", "󰎲  ", "󰼓  ", "󰎴  " },
      },
      code = {
        width = "block",
        border = "thin",
        left_pad = 1,
        right_pad = 1,
        min_width = 45,
      },
      bullet = {
        icons = { "●", "○", "◆", "◇" },
        right_pad = 1,
      },
      checkbox = {
        unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
        checked = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        },
      },
      quote = {
        icon = "▋",
      },
      pipe_table = {
        preset = "round",
        cell = "padded",
      },
    },
  },
}
