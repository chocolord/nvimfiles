vim.g.python_host_prog = '/usr/bin/python'
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- my plugins
require('lazy').setup({
    -- LSP
    'neovim/nvim-lspconfig', -- LSP client/framework
    'j-hui/fidget.nvim', -- LSP status infos
    { 'glepnir/lspsaga.nvim', event = 'BufRead', config = function() require('lspsaga').setup({}) end, dependencies = { {'nvim-tree/nvim-web-devicons'} } },

    'nvim-tree/nvim-web-devicons', -- icons
    'nvim-tree/nvim-tree.lua', -- tree explorer

    'tpope/vim-surround', -- Surrounding

    'hrsh7th/nvim-cmp', -- completion tool
    'hrsh7th/cmp-nvim-lsp', -- completion lsp provider
    'hrsh7th/cmp-nvim-lsp-signature-help', -- completion lsp provider
    'hrsh7th/cmp-buffer', -- completion buffer provier
    'hrsh7th/cmp-path', -- completion path tool
    'hrsh7th/cmp-cmdline', -- completion cmdline

    'SirVer/ultisnips', -- Snippets engine
    'honza/vim-snippets', -- Common snippets
    'quangnguyen30192/cmp-nvim-ultisnips', -- completion UltiSnips provider

    'terryma/vim-multiple-cursors', -- Multiple cursors

    'ellisonleao/gruvbox.nvim', -- TreeSitter gruvbox
    'EdenEast/nightfox.nvim', -- Nightfox theme

    'feline-nvim/feline.nvim', -- Feline statusline
    'lewis6991/gitsigns.nvim', -- Git decorations
    'TimUntersberger/neogit', -- Git GUI

    'simrat39/symbols-outline.nvim', -- view for Symbols with LSP

    'samodostal/image.nvim', -- Image viewer

    'nvim-lua/plenary.nvim', -- Lua library
    { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }, -- Telescope

    'kazhala/close-buffers.nvim', -- Close buffers

    'nelsyeung/twig.vim', -- Twig syntax, snippets, etc.

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' }, -- TreeSitter AST
})

-- my editor configuration
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.compatible = false
vim.opt.modeline = true
vim.opt.modelines = 5
vim.opt.hlsearch = false
vim.opt.mouse = "a"
vim.opt.fileformat = "unix"
vim.opt.scrolloff = 6
vim.opt.clipboard = "unnamedplus"
vim.opt.visualbell = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.fileencodings = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.g.mapleader = "-"

vim.cmd([[
    syntax on
    colorscheme nightfox
]])

-- my UltiSnips configuration
vim.g.UltiSnipsExpandTrigger = "²²"
vim.g.UltiSnipsSnippetDirectories = {'~/.config/nvim/UltiSnips'}
vim.g.UltiSnipsJumpForwardTrigger = "<c-l>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-h>"
vim.g.UltiSnipsEditSplit = "vertical"

require"setups"

-- my mappings
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<space>", "-", { remap = true, desc = "map spacebar to the leader" } )
vim.keymap.set("n", "<c-j>", "30j")
vim.keymap.set("n", "<c-k>", "30k")
vim.keymap.set("n", "<leader><c-s>", function() vim.opt_local.hlsearch = vim.opt_local.hlsearch and false or true end)
vim.keymap.set("n", "<leader>ng", require'neogit'.open)
vim.keymap.set("n", "nt", require'nvim-tree.api'.tree.toggle)
vim.keymap.set("n", "<leader>nf", function () require'nvim-tree.api'.tree.find_file(vim.api.nvim_buf_get_name(0)) end)
vim.keymap.set("n", "so", require'symbols-outline'.toggle_outline)
vim.keymap.set("i", "<S-Insert>", "<C-R>*")

-- my telescope mappings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics)

-- my nvim-tree mappings
vim.keymap.set("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next)
vim.keymap.set("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev)
vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)

-- my buffer closer mappings
local function closer (type)
    return function() require("close_buffers").delete({ type = type }) end
end
vim.keymap.set("n", "<leader>bdh", closer("hidden"), { silent = true })
vim.keymap.set("n", "<leader>bdn", closer("nameless"), { silent = true })
vim.keymap.set("n", "<leader>bda", closer("all"), { silent = true })
vim.keymap.set("n", "<leader>bdo", closer("other"), { silent = true })

-- my functions
vim.api.nvim_create_user_command("Latin1", "edit ++enc=latin1", {})
vim.api.nvim_create_user_command("Utf8", "edit ++enc=utf8", {})
