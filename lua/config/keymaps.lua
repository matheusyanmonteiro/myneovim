local map = vim.keymap.set

-- Operacoes frequentes. <leader> e a barra de espaco definida em init.lua.
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Salvar arquivo" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Fechar janela" })

-- Remove o destaque da busca sem apagar o termo pesquisado.
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Limpar destaque da busca" })

-- Navega entre janelas sem precisar digitar <C-w> antes.
map("n", "<C-h>", "<C-w>h", { desc = "Ir para janela a esquerda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ir para janela abaixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Ir para janela acima" })
map("n", "<C-l>", "<C-w>l", { desc = "Ir para janela a direita" })

-- Buffers sao arquivos carregados na memoria, independentemente das janelas.
map("n", "]b", "<cmd>bnext<cr>", { desc = "Proximo buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Buffer anterior" })
map("n", "<leader>bl", "<cmd>buffer #<cr>", { desc = "Ultimo buffer usado" })
-- Sem !: o Neovim recusa fechar se houver alteracoes ainda nao salvas.
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Fechar buffer" })

-- Terminal inferior. <C-\> tambem funciona de dentro do proprio shell.
local toggle_terminal = function()
  require("config.terminal").toggle()
end
map("n", "<leader>tt", toggle_terminal, { desc = "Alternar terminal" })
map({ "n", "t" }, "<C-\\>", toggle_terminal, { desc = "Alternar terminal" })
-- O primeiro Esc pertence ao shell; dois Esc retornam ao modo normal do Neovim.
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Sair do modo terminal" })

-- Mantem a selecao ativa ao ajustar a indentacao de um bloco.
map("v", "<", "<gv", { desc = "Diminuir indentacao" })
map("v", ">", ">gv", { desc = "Aumentar indentacao" })
