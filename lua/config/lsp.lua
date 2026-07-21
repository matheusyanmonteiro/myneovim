local M = {}

function M.setup()
  -- Diagnosticos pertencem ao Neovim; o LSP e apenas uma das fontes.
  vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    signs = true,
    virtual_text = {
      spacing = 2,
      prefix = "●",
      source = "if_many",
    },
    float = {
      border = "rounded",
      source = true,
    },
  })

  local group = vim.api.nvim_create_augroup("config-lsp", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    desc = "Atalhos disponiveis quando um servidor LSP conecta",
    callback = function(event)
      local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
      local map = function(lhs, rhs, desc, mode)
        vim.keymap.set(mode or "n", lhs, rhs, { buffer = event.buf, desc = desc })
      end

      map("gd", vim.lsp.buf.definition, "LSP: ir para definicao")
      map("gD", vim.lsp.buf.declaration, "LSP: ir para declaracao")
      map("gr", vim.lsp.buf.references, "LSP: listar referencias")
      map("gI", vim.lsp.buf.implementation, "LSP: ir para implementacao")
      map("K", vim.lsp.buf.hover, "LSP: documentacao")
      map("<leader>ca", vim.lsp.buf.code_action, "LSP: acao de codigo", { "n", "x" })
      map("<leader>rn", vim.lsp.buf.rename, "LSP: renomear simbolo")
      map("<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, "LSP: formatar arquivo")
      map("<leader>ld", vim.diagnostic.open_float, "Diagnostico da linha")
      map("]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, "Proximo diagnostico")
      map("[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, "Diagnostico anterior")

      if client:supports_method("textDocument/inlayHint") then
        -- Tipos inferidos e nomes de parametros ajudam especialmente em C++.
        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
      end
    end,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp_lsp.default_capabilities(capabilities)
  end

  -- nvim-lspconfig fornece a base do clangd; aqui alteramos apenas nossas escolhas.
  vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
    },
  })
end

return M
