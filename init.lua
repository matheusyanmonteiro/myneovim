-- A tecla Leader inicia a maioria dos nossos atalhos personalizados.
-- Ela precisa ser definida antes de carregar plugins e atalhos.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("vicarious").setup()
require("config.terminal").setup()
require("config.keymaps")
require("config.lazy")
