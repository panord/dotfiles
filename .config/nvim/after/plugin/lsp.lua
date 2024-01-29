local lsp = require('lsp-zero')

lsp.setup_servers({'lua_ls', 'rust_analyzer', 'clangd', 'bashls', 'cmake', 'csharp_ls'})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.preset({'lsp-only', set_lsp_keymaps = true, manage_nvim_cmp = true, suggest_lsp_servers = true})
lsp.setup()

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', {buffer = bufnr})
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr})
  vim.keymap.set('n', 'gf', '<cmd>Telescope lsp_incoming_calls<cr>', {buffer = bufnr})
end)

lsp.preset('lsp-compe')
lsp.setup()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local cmp_config = lsp.defaults.cmp_config({})

cmp.setup(cmp_config)
