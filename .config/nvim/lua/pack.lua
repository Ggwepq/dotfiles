-- add plugins
vim.pack.add({
    -- "https://github.com/bluz71/vim-moonfly-colors",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/folke/flash.nvim",
    "https://github.com/norcalli/nvim-colorizer.lua",
    "https://github.com/RedsXDD/neopywal.nvim",
})

---- mini files ----
require("mini.files").setup({
    mappings = {
        go_in = "<CR>",
        go_in_plus = "l",
        go_out = "_",
        go_out_plus = "h",
    }
})

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })

---- mini notify ----
local MiniNotify = require("mini.notify")
require("mini.notify").setup({
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

---- mini cmdline completion ----
require("mini.cmdline").setup({
    autocorrect = {enable = false}
})

---- mini surround ----
require("mini.surround").setup()
-- Default Keymaps
-- | `sa` | Add surrounding or Direct with 'saiw' |
-- | `sd` | Delete surrounding |
-- | `sr` | Replace surrounding |
-- | `sf` | Find surrounding (right) |
-- | `sF` | Find surrounding (left) |
-- | `sh` | Highlight surrounding |
-- | `sn` | Update n_lines |
-- | `l` / `n` | as suffix for prev/next |

---- mini picker ----
local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")

MiniPick.setup()
MiniExtra.setup()

-- keymaps
vim.keymap.set("n", "<leader>pf", function() MiniPick.builtin.files({}, {
    source = {
        fallback = {"rg", "--files", "--hidden", "--glob", "!.git/*"}
    }
}) end, {desc = "Mini File Picker"})
vim.keymap.set("n", "<leader>ps", function() MiniPick.builtin.grep() end, {desc = "<cword>"})
vim.keymap.set("n", "<leader>vh", function() MiniPick.builtin.help() end, {desc = "Mini Help"})

vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, {desc = "Mini Picker Diagnostic"})
vim.keymap.set("n", "<leader>pk", function() MiniExtra.pickers.keymaps() end, {desc = "Search Keymaps"})


---- mini completions ----
local MiniCompletion = require("mini.completion")

MiniCompletion.setup({
    lsp_completion = {
        auto_setup = true,
        process_items = function (items, base)
            return MiniCompletion.default_process_items(items, base, {
                filtersort = "fuzzy",
            })
        end,
    }
})


---- mini snippets ----
local MiniSnippets = require("mini.snippets")

MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(),
    },
    expand = {
        insert = function(snippet)
            MiniSnippets.default_insert(snippet, { empty_tabstop = "" })
        end,
    }
})

MiniSnippets.start_lsp_server({match = false})

---- mini snippets ----
require("mini.pairs").setup()

---- nvim treesitter ----
require("treesitter")

---- lsp ----
require("lsp")

---- colorizer ----
require("colorizer").setup()

---- flash ----
require("flash").setup()

vim.keymap.set({"n","x","o"}, "<leader>s", function() require("flash").jump() end, {desc = "Flash Jump"})
vim.keymap.set({"n","x","o"}, "<leaker>S", function() require("flash").treesitter() end, {desc = "Flash Treesitter"})
vim.keymap.set("o","<leader>r", function() require("flash").remote() end, {desc = "Remote Flash "})
vim.keymap.set({"x","o"}, "<leader>R", function() require("flash").treesitter_search() end, {desc = "Flash Treesitter Search"})

---- colorizer ----
require("neopywal").setup({
    transparent_background = true,
    plugins = {
        treesitter = true,
        telescope = true,
    }
})
