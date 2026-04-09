-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Go development keymaps
map("n", "<leader>gr", "<cmd>GoRun<cr>", { desc = "Go Run" })
map("n", "<leader>gt", "<cmd>GoTest<cr>", { desc = "Go Test" })
map("n", "<leader>gT", "<cmd>GoTestFile<cr>", { desc = "Go Test File" })
map("n", "<leader>gc", "<cmd>GoCoverage<cr>", { desc = "Go Coverage" })
map("n", "<leader>gv", "<cmd>GoVet<cr>", { desc = "Go Vet" })
map("n", "<leader>gb", "<cmd>GoBuild<cr>", { desc = "Go Build" })
map("n", "<leader>gi", "<cmd>GoInstall<cr>", { desc = "Go Install" })
map("n", "<leader>gm", "<cmd>GoMod<cr>", { desc = "Go Mod" })
map("n", "<leader>gf", "<cmd>GoFmt<cr>", { desc = "Go Format" })
map("n", "<leader>gI", "<cmd>GoImports<cr>", { desc = "Go Imports" })
map("n", "<leader>gl", "<cmd>GoLint<cr>", { desc = "Go Lint" })
map("n", "<leader>gs", "<cmd>GoFillStruct<cr>", { desc = "Go Fill Struct" })
map("n", "<leader>ge", "<cmd>GoIfErr<cr>", { desc = "Go If Err" })
map("n", "<leader>gat", "<cmd>GoAddTag<cr>", { desc = "Go Add Tags" })
map("n", "<leader>grt", "<cmd>GoRmTag<cr>", { desc = "Go Remove Tags" })
map("n", "<leader>gtj", "<cmd>GoTagAdd json<cr>", { desc = "Go Add JSON Tags" })
map("n", "<leader>gty", "<cmd>GoTagAdd yaml<cr>", { desc = "Go Add YAML Tags" })

-- Kubernetes YAML helpers
map("n", "<leader>ys", "<cmd>Telescope yaml_schema<cr>", { desc = "Select YAML Schema" })

-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Terminal left" })
map("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Terminal down" })
map("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Terminal up" })
map("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Terminal right" })

-- Better window management
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })

-- Improved search and replace
map("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })
map("v", "<leader>sr", "y:%s/<C-r>\"//gI<Left><Left><Left>", { desc = "Replace selected text" })

-- Quick file operations
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>fR", "<cmd>Rename<cr>", { desc = "Rename File" })

-- Better indenting
map("v", "<", "<gv", { desc = "Unindent line" })
map("v", ">", ">gv", { desc = "Indent line" })

-- Clear search highlighting
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Quick save and quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all files" })
map("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "Quit all" })

-- Better line navigation
map("n", "j", "gj", { desc = "Move down by visual line" })
map("n", "k", "gk", { desc = "Move up by visual line" })

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
