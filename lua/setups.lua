-- Require and call setup function somewhere in your init.lua
require('image').setup {
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

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- my mappings
  vim.keymap.set("n", "<space>la", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<space>lh", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<space>ldf", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "<space>ldh", vim.lsp.buf.document_highlight, bufopts)
  vim.keymap.set("n", "<space>lds", vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set("n", "<space>lrn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>lsh", vim.lsp.buf.signature_help, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.phpactor.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require'lspconfig'.vuels.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = { '/home/user/.nvm/versions/node/v16.17.1/bin/vls' }
}
require'lspconfig'.dockerls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = { '/home/user/.nvm/versions/node/v16.17.1/bin/docker-langserver' }
}
require'lspconfig'.bashls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = { '/home/user/.nvm/versions/node/v16.17.1/bin/bash-language-server' }
}
require'lspconfig'.sqlls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = { '/home/user/.nvm/versions/node/v16.17.1/bin/sql-language-server' }
}
require'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

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

require("telescope").setup {
    defaults = {
        file_ignore_patterns = { "^vendor/" }
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

require'nvim-tree'.setup({
    view = {
        mappings = {
            list = {
                { key = { "cd", "<C-]>", "<2-RightMouse>" },    action = "cd" },
                { key = "<C-s>",                          action = "vsplit" },
                { key = "l",                          action = "enter" },
                { key = "h",                          action = "close_node" },
            }
        }
    }
})

require'feline'.setup()
require'gitsigns'.setup()
require'symbols-outline'.setup()
require'close_buffers'.setup{}
require'neogit'.setup{}
require'fidget'.setup{}

-- Set up nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<c-f>'] = cmp.mapping.scroll_docs(4),
    ['<c-b>'] = cmp.mapping.select_prev_item(-4),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-e>'] = cmp.mapping.abort(),
    ['<tab>'] = cmp.mapping.confirm({ select = true })
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
  })
})
