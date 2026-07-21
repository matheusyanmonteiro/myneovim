return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
      },
      preview_config = {
        border = "rounded",
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Usamos ]h/[h porque ]c/[c continua livre para diff-mode e contexto.
        map("n", "]h", function()
          gs.nav_hunk("next")
        end, "Proximo hunk Git")
        map("n", "[h", function()
          gs.nav_hunk("prev")
        end, "Hunk Git anterior")
        map("n", "<leader>hs", gs.stage_hunk, "Git: adicionar/remover hunk do stage")
        map("x", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Git: adicionar/remover selecao do stage")
        map("n", "<leader>hr", gs.reset_hunk, "Git: descartar hunk")
        map("x", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Git: descartar selecao")
        map("n", "<leader>hS", gs.stage_buffer, "Git: adicionar arquivo ao stage")
        map("n", "<leader>hp", gs.preview_hunk, "Git: visualizar hunk")
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, "Git: blame da linha")
        map("n", "<leader>hd", gs.diffthis, "Git: diff deste arquivo")
        map({ "o", "x" }, "ih", gs.select_hunk, "Selecionar hunk Git")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
    },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git: abrir diff do projeto" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Git: fechar diff" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Git: historico do arquivo" },
      { "<leader>gb", "<cmd>Gitsigns blame_line full=true<cr>", desc = "Git: blame da linha" },
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Git: alternar blame continuo" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_horizontal" },
      },
    },
  },
}
