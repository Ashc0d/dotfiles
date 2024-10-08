-- This is configuration for custom key mapping for neovim


vim.g.mapleader = " "
vim.keymap.set("n", "<leader>p", vim.cmd.Ex)

--  Invokes the :%s command (which is used for search and replace)
vim.keymap.set("n", "<leader>s", ":%s/", { noremap = true })

--  Invokes the / command (which is used for search)
vim.keymap.set("n", "<leader>f", "/", { noremap = true })
