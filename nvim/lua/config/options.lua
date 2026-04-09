-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Better editing experience
opt.relativenumber = true -- Show relative line numbers
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
opt.wrap = false -- Don't wrap lines
opt.linebreak = true -- Break lines at word boundaries
opt.breakindent = true -- Maintain indent when wrapping

-- Better search
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Case sensitive when uppercase present
opt.incsearch = true -- Show matches as you type
opt.hlsearch = true -- Highlight search matches

-- Indentation
opt.tabstop = 4 -- Tab width
opt.shiftwidth = 4 -- Indent width
opt.softtabstop = 4 -- Tab width in insert mode
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart auto-indenting

-- File handling
opt.autoread = true -- Auto-reload files changed outside vim
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before overwriting
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Enable persistent undo
opt.undodir = vim.fn.expand("~/.config/nvim/undo") -- Undo directory

-- Better completion
opt.completeopt = { "menuone", "noselect", "noinsert" }
opt.pumheight = 10 -- Limit popup menu height

-- Display
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.signcolumn = "yes" -- Always show sign column
opt.colorcolumn = "80,120" -- Show column guides at 80 and 120
opt.cursorline = true -- Highlight current line
opt.showmode = false -- Don't show mode (status line shows it)
opt.conceallevel = 0 -- Don't hide characters

-- Better splits
opt.splitbelow = true -- New horizontal splits below
opt.splitright = true -- New vertical splits to the right

-- Mouse and clipboard
opt.mouse = "a" -- Enable mouse in all modes
opt.clipboard = "unnamedplus" -- Use system clipboard

-- Go-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    opt.tabstop = 4
    opt.shiftwidth = 4
    opt.softtabstop = 4
    opt.expandtab = false -- Go uses tabs
  end,
})

-- YAML-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yml" },
  callback = function()
    opt.tabstop = 2
    opt.shiftwidth = 2
    opt.softtabstop = 2
    opt.expandtab = true -- YAML uses spaces
  end,
})

-- JSON-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    opt.tabstop = 2
    opt.shiftwidth = 2
    opt.softtabstop = 2
    opt.expandtab = true
  end,
})

-- Lua-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    opt.tabstop = 2
    opt.shiftwidth = 2
    opt.softtabstop = 2
    opt.expandtab = true
  end,
})

-- Performance improvements
opt.updatetime = 250 -- Faster completion and diagnostics
opt.timeoutlen = 500 -- Which-key timeout
opt.lazyredraw = false -- Don't redraw during macros (can cause issues)

-- Better folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false -- Don't fold by default
opt.foldlevel = 99 -- High fold level

-- Create undo directory if it doesn't exist
vim.fn.mkdir(vim.fn.expand("~/.config/nvim/undo"), "p")
