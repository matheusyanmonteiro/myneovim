return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>ss", function() require("persistence").load() end, desc = "Sessao: restaurar diretorio atual" },
      { "<leader>sS", function() require("persistence").select() end, desc = "Sessao: escolher" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Sessao: restaurar ultima" },
      { "<leader>sd", function() require("persistence").stop() end, desc = "Sessao: nao salvar ao sair" },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash: saltar" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash: selecionar estrutura" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Flash: operador remoto" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash: buscar estrutura" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Mostrar atalhos deste buffer",
      },
    },
    opts = {
      preset = "modern",
      delay = 300,
      spec = {
        { "<leader>a", group = "IA / Agentes" },
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Codigo / C++" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Busca" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Hunks Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>m", group = "Markdown" },
        { "<leader>s", group = "Sessoes" },
        { "<leader>t", group = "Terminal" },
        { "<leader>u", group = "Vicarious / Study" },
      },
    },
  },
}
