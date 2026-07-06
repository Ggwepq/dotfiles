local keymap = vim.keymap

-- Set Space as your leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation (use Ctrl + h/j/k/l to jump split panes)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Close window
keymap.set("n", "<C-q>", "<C-w>q", { desc = "Close current window" })

-- Clear search highlights easily by hitting Esc
keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- Keep cursor centered when scrolling pages
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- replace selected text WITHOUT losing what you copied
keymap.set("x", "p", "P", {desc = "Paste over selection without losing yanked text" })

-- delete text without saving it to any registry
keymap.set({"n", "v"}, "<leader>d" ,[["_d]], {desc = "Delete without yanking" })

keymap.set({"n","v"}, "y", '"+y', { desc = "yank to system clipboard" })
keymap.set("n", "Y", '"+y$', { desc = "yank to end of line to system clipboard" })
keymap.set({"n","v"}, "p", '"+p', { desc = "Paste from system clipboard" })
keymap.set({"n","v"}, "P", '"+P', { desc = "Paste before from system clipboard" })
keymap.set({"n","v"}, "x", '"+x', { desc = "cut to system clipboard" })

-- move lines up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "move lines down in visual selection" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "move lines down in visual selection" })

-- indentation
keymap.set("v", "<", "<gv", {desc = "Unindent and keep selection" })
keymap.set("v", ">", ">gv", {desc = "Indent and keep selection" })

-- join lines without moving cursor
keymap.set("n", "J", "mzJ`z", {desc = "Join lines without moving cursor"})

-- stay cursor to center when searching
keymap.set("n", "n", "nzzzv", {desc = "Next search result cursor centered"})
keymap.set("n", "N", "Nzzzv", {desc = "Previous search result cursor centered"})

-- replace all word under cursor
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Replace word cursor globally"})

-- restart neovim
keymap.set("n", "<leader>re", "<cmd>restart<cr>", {desc = "Restart Neovim (:restart)"})

-- open netrw
keymap.set("n", "<leader>e", "<cmd>Ex<cr>", {desc = "Restart Neovim (:restart)"})

keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, {desc = "Toggle Builtin Undotree" })
