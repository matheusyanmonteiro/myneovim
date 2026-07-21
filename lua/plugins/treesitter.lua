local parsers = {
  "bash",
  "c",
  "cpp",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "query",
  "vim",
  "vimdoc",
  "yaml",
}

local highlighted_filetypes = {
  "c",
  "cpp",
  "help",
  "json",
  "lua",
  "markdown",
  "query",
  "sh",
  "vim",
  "yaml",
}

-- A indentacao do Treesitter ainda e experimental. Limitamos seu uso as
-- linguagens cujas queries de indentacao instalamos e testamos.
local indented_filetypes = {
  "c",
  "cpp",
  "json",
  "lua",
  "sh",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- A API nova requer Neovim 0.12 e nao oferece suporte a lazy-loading.
    branch = "main",
    lazy = false,
    -- Uma unica fila atualiza o que existe e instala nosso conjunto configurado.
    build = function()
      local treesitter = require("nvim-treesitter")
      treesitter.update(nil, { summary = true }):wait(300000)
      treesitter.install(parsers, { summary = true }):wait(300000)
    end,
    config = function()
      local treesitter = require("nvim-treesitter")

      treesitter.setup({})

      local group = vim.api.nvim_create_augroup("config-treesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = highlighted_filetypes,
        desc = "Ativar destaque de sintaxe com Treesitter",
        callback = function(args)
          -- O Neovim escolhe o parser correspondente ao filetype do buffer.
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = indented_filetypes,
        desc = "Usar indentacao do Treesitter",
        callback = function(args)
          -- indentexpr e uma expressao avaliada pelo Neovim a cada nova linha.
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "[c",
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end,
        desc = "Ir para o contexto acima",
      },
    },
    opts = {
      max_lines = 3,
      multiline_threshold = 5,
      trim_scope = "outer",
      mode = "cursor",
    },
  },
}
