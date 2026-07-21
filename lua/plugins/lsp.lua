return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      ensure_installed = { "clangd" },
      automatic_enable = { "clangd" },
    },
    config = function(_, opts)
      -- O spec do mason.nvim acima ja chamou setup antes desta dependencia.
      require("config.lsp").setup()
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    cmd = {
      "MasonToolsInstall",
      "MasonToolsInstallSync",
      "MasonToolsUpdate",
      "MasonToolsUpdateSync",
    },
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- Estas ferramentas tambem serao reconstruidas em uma maquina nova.
      ensure_installed = { "clangd", "codelldb" },
      auto_update = false,
      run_on_start = true,
      start_delay = 1000,
      debounce_hours = 24,
    },
  },
}
