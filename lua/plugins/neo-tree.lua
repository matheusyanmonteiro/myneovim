return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- A linha v3.x recebe correcoes sem introduzir mudancas incompatíveis.
    branch = "v3.x",
    -- Precisa estar disponivel cedo para substituir o explorador nativo (netrw).
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Componentes de interface usados para desenhar a arvore e popups.
      "MunifTanjim/nui.nvim",
      -- Escolhe um icone de acordo com o nome e o tipo de cada arquivo.
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>e",
        "<cmd>Neotree toggle reveal_force_cwd<cr>",
        desc = "Alternar explorador de arquivos",
      },
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",
      window = {
        position = "left",
        width = 34,
        title = " VICARIOUS://FILES ",
      },
      filesystem = {
        -- Ao trocar de arquivo, localiza esse arquivo automaticamente na arvore.
        follow_current_file = {
          enabled = true,
        },
        -- Atualiza a arvore quando arquivos mudam fora do Neovim.
        use_libuv_file_watcher = true,
        -- `nvim .` abre o Neo-tree em vez do explorador nativo netrw.
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          -- Arquivos como .gitignore ficam visiveis durante o desenvolvimento.
          hide_dotfiles = false,
          -- Dependencias e artefatos ignorados pelo Git continuam ocultos.
          hide_gitignored = true,
        },
      },
    },
  },
}
