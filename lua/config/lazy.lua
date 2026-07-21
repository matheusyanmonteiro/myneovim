local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Na primeira abertura, baixa o proprio gerenciador de plugins.
if not vim.uv.fs_stat(lazypath) then
  local repository = "https://github.com/folke/lazy.nvim.git"
  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    repository,
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    error("Nao foi possivel instalar lazy.nvim:\n" .. output)
  end
end

-- Adiciona lazy.nvim ao runtimepath para que require("lazy") o encontre.
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Cada arquivo em lua/plugins/ pode declarar um ou mais plugins.
    { import = "plugins" },
  },
  install = {
    -- O tema VICARIOUS mora na propria configuracao; habamax e o plano B nativo.
    colorscheme = { "vicarious", "habamax" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  -- Nenhum plugin desta etapa usa pacotes LuaRocks.
  pkg = {
    sources = { "lazy", "packspec" },
  },
  rocks = {
    -- Evita manter uma segunda instalacao de Lua apenas para LuaRocks.
    enabled = false,
  },
  change_detection = {
    notify = false,
  },
})
