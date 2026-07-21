return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: iniciar/continuar" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: avancar linha" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: entrar na funcao" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: sair da funcao" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: alternar breakpoint" },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condicao do breakpoint: "))
        end,
        desc = "Debug: breakpoint condicional",
      },
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug: iniciar/continuar" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Debug: encerrar" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Debug: abrir REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Debug: repetir ultima sessao" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: alternar interface" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "x" }, desc = "Debug: avaliar expressao" },
    },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = { "scopes", "breakpoints", "stacks", "watches" },
            size = 40,
            position = "left",
          },
          {
            elements = { "repl", "console" },
            size = 10,
            position = "bottom",
          },
        },
      })

      dap.listeners.before.attach.config_dapui = dapui.open
      dap.listeners.before.launch.config_dapui = dapui.open
      dap.listeners.before.event_terminated.config_dapui = dapui.close
      dap.listeners.before.event_exited.config_dapui = dapui.close

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual" })

      local codelldb = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb,
          args = { "--port", "${port}" },
          detached = false,
        },
      }

      dap.configurations.cpp = {
        {
          name = "Executar arquivo C/C++ compilado",
          type = "codelldb",
          request = "launch",
          program = function()
            local beside_source = vim.fn.expand("%:p:r")
            local suggestion = vim.fn.executable(beside_source) == 1 and beside_source or (vim.fn.getcwd() .. "/")
            return vim.fn.input("Executavel: ", suggestion, "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          runInTerminal = true,
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },
}
