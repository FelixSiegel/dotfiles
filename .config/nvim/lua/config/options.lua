local vim = vim
-- See: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Indenation and tab width
vim.opt.expandtab = true
vim.opt.shiftwidth = 4 -- Amount of indent when using << and >>
vim.opt.tabstop = 4 -- how many spaces are shown per tab
vim.opt.softtabstop = 4 -- how many spaces are applied when pressing tab
vim.opt.smarttab = true -- don't need to delete each 4 spaces manualy, the system will recognize it
vim.opt.smartindent = true
vim.opt.autoindent = true -- keep indentation from previous line
vim.opt.breakindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true -- helps for jumping
vim.opt.cursorline = true

-- Store undos between sessions
vim.opt.undofile = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-sensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by deafult (useful for language server notifications)
vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Minimal number of screen lines to keep above and below and also below the cursor
vim.opt.scrolloff = 10

-- Sets how neovim will display certain whitespace characters in the editor
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣" }

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Folding settings using treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 20

-- Line length indicator
vim.opt.colorcolumn = "120"
