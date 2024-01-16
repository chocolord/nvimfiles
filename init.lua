vim.g.python_host_prog = '/usr/bin/python'
vim.g.python3_host_prog = '/usr/bin/python3'
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

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
    { -- LSP configurations
        'neovim/nvim-lspconfig',
        lazy = false,
    }, -- LSP configurations

    { -- LSP status infos
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = true,
        dependencies = { 'neovim/nvim-lspconfig' }
    },

    { -- tree explorer
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' }, -- icons
        opts = {
            disable_netrw = false,
            hijack_netrw = true,
            sync_root_with_cwd = true,
            git = { ignore = false },
            modified = { enable = true },
            on_attach = function (bufnr)
                local api = require("nvim-tree.api")
                api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set('n', "cd", api.tree.change_root_to_node, { desc = 'nvim-tree: CD', buffer = bufnr, noremap = true, silent = true, nowait = true })
                vim.keymap.set('n', '<C-s>', api.node.open.vertical, { desc = 'nvim-tree: Open: Vertical Split', buffer = bufnr, noremap = true, silent = true, nowait = true })
                vim.keymap.set('n', 'l', api.node.open.edit, { desc = 'nvim-tree: Open', buffer = bufnr, noremap = true, silent = true, nowait = true })
                vim.keymap.set('n', 'h', api.node.navigate.parent_close, { desc = 'nvim-tree: Close Directory', buffer = bufnr, noremap = true, silent = true, nowait = true })
            end
        }
    }, -- tree explorer

    { 'tpope/vim-surround' }, -- Surrounding

    { -- Completion tool
        'hrsh7th/nvim-cmp',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp', -- completion lsp provider
            'hrsh7th/cmp-nvim-lsp-signature-help', -- completion lsp provider
            'hrsh7th/cmp-buffer', -- completion buffer provier
            'hrsh7th/cmp-path', -- completion path tool
            'hrsh7th/cmp-cmdline', -- completion cmdline
            'saadparwaiz1/cmp_luasnip', -- LuapSnip provider
        },
        lazy = false,
        config = function ()
            local cmp = require'cmp'
            local luasnip = require'luasnip'

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {},
                mapping = cmp.mapping.preset.insert({
                    --[[
                    ['<c-f>'] = cmp.mapping.scroll_docs(4),
                    ['<c-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<c-space>'] = cmp.mapping.complete(),
                    ['<c-g>'] = cmp.mapping.select_prev_item(),
                    ['<c-n>'] = cmp.mapping.select_next_item(),
                    ['<c-e>'] = cmp.mapping.abort(),
                    ['<tab>'] = cmp.mapping.confirm({ select = true })
                    ]]
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                })
            })
        end
    }, -- Completion tool

    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        -- build = "make install_jsregexp"
    },

    { 'terryma/vim-multiple-cursors' }, -- Multiple cursors

    { 'EdenEast/nightfox.nvim' }, -- Nightfox theme

    { 'feline-nvim/feline.nvim', config = true }, -- Feline statusline

    { 'lewis6991/gitsigns.nvim', config = true }, -- Git decorations

    { -- Git GUI
        'NeogitOrg/neogit',
        config = true,
        dependencies = { 'nvim-lua/plenary.nvim' }, -- Lua library
    },

    { -- view for Symbols with LSP
        'simrat39/symbols-outline.nvim',
        config = true
    },

    { -- Image viewer
        'samodostal/image.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }, -- Lua library
        opts = {
            render = {
                min_padding = 5,
                show_label = true,
                use_dither = true,
                foreground_color = false,
                background_color = false
            },
            events = {
                update_on_nvim_resize = true,
            },
        }
    },

    { -- Telescope
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim', "fhill2/telescope-ultisnips.nvim" },
        cmd = "Telescope",
        config = function ()
            local function find_file(prompt_bufnr)
                local entry = require("telescope.actions.state").get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                if not require("nvim-tree.view").is_visible() then require("nvim-tree.api").tree.open() end
                require("nvim-tree.api").tree.find_file(entry[1])
                require("nvim-tree.api").node.open.preview()
            end

            local function find_file_edit(prompt_bufnr)
                find_file(prompt_bufnr)
                require("nvim-tree.api").node.open.edit()
            end

            require"telescope".setup{
                defaults = {
                    file_ignore_patterns = { "^vendor/", "include/Javascript/build/", "node_modules/" }
                },
                pickers = {
                    find_files = {
                        mappings = {
                            i = {
                                ["$s"] = "select_vertical",
                                ["$f"] = find_file,
                                ["$e"] = find_file_edit,
                            },
                            n = {
                                ["ff"] = find_file,
                                ["fe"] = find_file_edit,
                                ["ss"] = "select_vertical",
                            },
                        },
                    },
                },
            }
        end,
        init =
            function ()
                require"telescope".load_extension"notify"
                require"telescope".load_extension"ultisnips"
            end
    }, -- Telescope

    {
        'nelsyeung/twig.vim', -- Twig syntax, snippets, etc.
        config = true,
        ft = 'twig'
    },

    { -- TreeSitter AST
        'nvim-treesitter/nvim-treesitter',
        config = true,
        build = ':TSUpdate'
    },

    { -- Trouble
        "folke/trouble.nvim",
        config = function ()
            require("trouble").setup()
        end
    },

    { -- pretty notifications
        'rcarriga/nvim-notify',
        config = true
    },

    { -- Lsp Lines
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = true
    },

    { -- git-conflict
        'akinsho/git-conflict.nvim',
        version = "*",
        config = true,
        opts = {
            default_mappings = {
                ours = 'o',
                theirs = 't',
                none = '0',
                both = 'b',
                next = 'n',
                prev = 'p',
            }
        }
    }

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
vim.cmd.syntax('on')
vim.cmd.colorscheme('nightfox')

-- my functions
vim.api.nvim_create_user_command("Latin1", "edit ++enc=latin1", {})
vim.api.nvim_create_user_command("Utf8", "edit ++enc=utf8", {})

-- my mappings
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<space>", "-", { remap = true, desc = "map spacebar to the leader" } )
vim.keymap.set("n", "<c-j>", "30j")
vim.keymap.set("n", "<c-k>", "30k")
vim.keymap.set("n", "<leader><c-s>", function() vim.opt_local.hlsearch = vim.opt_local.hlsearch and false or true end)
vim.keymap.set("i", "<S-Insert>", "<C-R>*")

-- my nvim-tree mappings
vim.keymap.set("n", "nt", require'nvim-tree.api'.tree.toggle)
vim.keymap.set("n", "<leader>nf", function () require'nvim-tree.api'.tree.find_file(vim.api.nvim_buf_get_name(0)) end)

-- my telescope mappings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fp", builtin.builtin)
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics)

-- symbols-outline
vim.keymap.set("n", "so", require'symbols-outline'.toggle_outline)

-- neogit
vim.keymap.set("n", "<leader>ng", require'neogit'.open)

-- LuaSnip keymaps
-- vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true}) 
vim.keymap.set({"i", "s"}, "<C-L>", function() require'luasnip'.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() require'luasnip'.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if require'luasnip'.choice_active() then
		require'luasnip'.change_choice(1)
	end
end, {silent = true})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { noremap=true, silent=true, buffer=ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, opts)
    end
})

local capabilities = require('cmp_nvim_lsp').default_capabilities() -- nvim-cmp completion capabilities

local lspconfig = require'lspconfig'
local servers = { 'phpactor', 'vuels', 'dockerls', 'bashls', 'sqlls' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup { capabilities = capabilities }
end

lspconfig.lua_ls.setup {
    -- flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        Lua = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            runtime = { version = 'LuaJIT', },
            -- Get the language server to recognize the `vim` global
            diagnostics = { globals = {'vim'}, },
            -- Make the server aware of Neovim runtime files
            workspace = { library = vim.api.nvim_get_runtime_file("", true), },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false, },
        },
    },
}
