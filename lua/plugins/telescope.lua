return {
  {
    "nvim-telescope/telescope.nvim",
    -- Usa a versao estavel mais recente; lazy-lock.json fixa o commit exato.
    version = "*",
    cmd = "Telescope",
    dependencies = {
      -- Biblioteca de funcoes assincronas usada internamente pelo Telescope.
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            prompt_title = " VICARIOUS // FILE INDEX ",
          })
        end,
        desc = "Procurar arquivos",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep({ prompt_title = " VICARIOUS // SIGNAL SEARCH " })
        end,
        desc = "Procurar texto no projeto",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers({ prompt_title = " VICARIOUS // BUFFER MEMORY " })
        end,
        desc = "Procurar buffers abertos",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags({ prompt_title = " VICARIOUS // MANUAL DATABASE " })
        end,
        desc = "Procurar na ajuda",
      },
    },
    opts = {
      defaults = {
        -- Exibe somente a parte relevante de caminhos muito longos.
        path_display = { "smart" },
        -- Entrada e melhores resultados ficam juntos no topo da janela.
        sorting_strategy = "ascending",
        prompt_prefix = "   ",
        selection_caret = " 󰜴 ",
        entry_prefix = "   ",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        layout_config = {
          prompt_position = "top",
          horizontal = {
            preview_width = 0.55,
          },
        },
      },
    },
  },
}
