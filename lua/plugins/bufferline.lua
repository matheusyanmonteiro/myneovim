return {
  {
    "akinsho/bufferline.nvim",
    -- Segue releases estaveis; o commit exato fica no lazy-lock.json.
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        mode = "buffers",
        -- Nao forca o fechamento de arquivos modificados.
        close_command = "bdelete %d",
        right_mouse_command = "bdelete %d",
        separator_style = "slant",
        always_show_bufferline = false,
        show_close_icon = false,
        diagnostics = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = " VICARIOUS://FILES ",
            text_align = "center",
            separator = true,
          },
        },
      },
    },
  },
}
