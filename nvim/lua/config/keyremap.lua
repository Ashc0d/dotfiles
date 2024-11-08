-- This is configuration for custom key mapping for neovim

-- Leader key
vim.g.mapleader = " "

-- Open the file explorer (equivalent to :Ex command) with <leader>pv
vim.keymap.set("n", "<leader>p", vim.cmd.Ex)

--  Invokes the :%s command (which is used for search and replace)
vim.keymap.set("n", "<leader>s", ":%s/", { noremap = true })

-- Begin a search and replace for the word under the cursor throughout the file
vim.keymap.set("n", "<leader>f", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Paste over selected text without yanking it (greatest remap ever)
vim.keymap.set("x", "<leader>pw", [["_dP]])

-- Move selected line(s) down in visual mode and reselect them
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Move selected line(s) up in visual mode and reselect them
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join the current line with the one below and keep the cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

