vim.g.netrw_banner = 0
local opt = vim.opt
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.nu = true

opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4

opt.wrap = false
opt.smartindent = true
opt.inccommand = "split"

opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8

opt.splitbelow = true
opt.splitright = true

opt.ignorecase = true
opt.smartcase = true
opt.laststatus = 3

opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.undofile = true

opt.completeopt = "menuone,noselect,fuzzy,nosort"
opt.shortmess:append("c")
opt.isfname:append("@-@")
opt.guicursor = ""

opt.signcolumn = "yes"
vim.o.cmdheight = 0


-- YANK

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})
