local opt = vim.opt

-- Interface
opt.number = true
-- Numeracao absoluta facilita localizar e comunicar linhas durante o estudo.
opt.relativenumber = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.laststatus = 3
opt.showmode = false
opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "",
  foldclose = "",
  diff = "╱",
  vert = "│",
}

-- Neovim 0.11+ permite definir uma borda padrao para janelas flutuantes.
pcall(function()
  opt.winborder = "rounded"
end)

-- Busca: ignora maiusculas, exceto quando digitamos uma maiuscula.
opt.ignorecase = true
opt.smartcase = true

-- Edicao
opt.mouse = "a"
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.undofile = true

-- Define exatamente o que uma sessao persistente deve reconstruir.
opt.sessionoptions = {
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "globals",
  "skiprtp",
}

-- Novas janelas aparecem onde esperamos.
opt.splitright = true
opt.splitbelow = true

-- Deixa feedback e atalhos mais responsivos.
opt.updatetime = 250
opt.timeoutlen = 400
