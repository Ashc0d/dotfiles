-- This is personal settings for neovim 


-- Start of config --

-- To display number line in each line
vim.opt.nu = true

-- vim.opt.relativenumber = true -- To set relative number line from the cursor
-- Highlights column 80, useful as a visual guide for line length
-- vim.opt.colorcolumn = "107"

-- Tabs and Space settings 

-- This setting controls how many spaces a tab character (\t) visually represents
 vim.opt.tabstop = 4

-- This defines how many spaces a "tab" or "backspace" key press inserts or removes while editing
 vim.opt.softtabstop = 4

-- This sets the number of spaces to use for indentation when using indentation commands (like >> to indent or << to un-indent)
 vim.opt.shiftwidth = 4

-- When this is enabled, pressing the tab key inserts spaces instead of a tab character.Since tabstop is set to 4, pressing tabs will inset 4 spaces.
vim.opt.expandtab = true

-- Automatically indents new lines based on the syntax of the code
vim.opt.smartindent = true

-- Other Settings

-- Disables line wrapping: long lines will be displayed as single, unbroken lines
vim.opt.wrap = false

-- Sets the directory for storing undo history, useful for persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo_history"

-- Enables persistent undo: undo history will be saved even after closing and reopening files
vim.opt.undofile = true

-- Disables search highlighting: found search results won't be highlighted after search is complete
vim.opt.hlsearch = false

-- Enables incremental search: highlights search results as you type
vim.opt.incsearch = true

-- Enables true color support in the terminal: allows for better color rendering in GUI terminals
vim.opt.termguicolors = true

-- Keeps 8 lines visible above and below the cursor while scrolling
vim.opt.scrolloff = 10
