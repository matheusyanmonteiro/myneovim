-- Regras locais: elas valem somente para buffers C++.
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.suffixesadd:append({ ".h", ".hpp" })

-- :make usa o compilador como ferramenta externa e converte erros em quickfix.
vim.opt_local.makeprg = "g++ -std=c++23 -Wall -Wextra -Wpedantic -g % -o %:r"

vim.keymap.set("n", "<leader>cc", function()
  vim.cmd.update()
  vim.cmd("silent make!")
  vim.cmd.cwindow()
end, { buffer = true, desc = "C++: compilar arquivo atual" })
