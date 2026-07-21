return {
  {
    "folke/sidekick.nvim",
    version = "*",
    cmd = "Sidekick",
    keys = {
      {
        "<C-.>",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "t", "i", "x" },
        desc = "IA: focar ou voltar ao editor",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "IA: alternar agente atual",
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "codex", focus = true })
        end,
        desc = "IA: abrir Codex",
      },
      {
        "<leader>aC",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "IA: abrir Claude",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select({ filter = { installed = true } })
        end,
        desc = "IA: escolher agente instalado",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "IA: escolher prompt",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "n", "x" },
        desc = "IA: enviar contexto atual",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "IA: enviar arquivo atual",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = "x",
        desc = "IA: enviar selecao visual",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "IA: encerrar sessao atual",
      },
    },
    opts = {
      -- NES depende do GitHub Copilot. Mantemos apenas os agentes locais que
      -- reutilizam a autenticacao existente dos CLIs Codex e Claude.
      nes = { enabled = false },
      cli = {
        watch = true,
        picker = "telescope",
        win = {
          layout = "right",
          split = { width = 78, height = 20 },
          wo = {
            winhighlight = table.concat({
              "Normal:SidekickNormal",
              "NormalNC:SidekickNormalNC",
              "WinSeparator:SidekickWinSeparator",
            }, ","),
          },
        },
        prompts = {
          estudar = table.concat({
            "Atue como meu mentor. Explique {this} em portugues, do fundamento ao uso pratico.",
            "Antes de propor mudancas, mostre como raciocinar e termine com um pequeno exercicio.",
          }, " "),
          explicar = "Explique {this} em portugues, incluindo o motivo de cada decisao importante.",
          diagnosticos = "Analise os diagnosticos de {file}, explique a causa e proponha a menor correcao segura:\n{diagnostics}",
          revisar = "Revise {file}. Priorize bugs, riscos e testes ausentes; explique cada achado em portugues.",
          testes = "Crie testes para {this}. Explique quais comportamentos cada teste protege.",
          cpp = "Analise {this} como codigo C++23. Verifique corretude, ownership, lifetime, complexidade e estilo moderno.",
        },
      },
    },
  },
}
