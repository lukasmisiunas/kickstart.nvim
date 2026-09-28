-- Metals is the Scala language server; nvim-metals starts it for Scala buffers
-- and adds its extra commands (import build, worksheets, decoded class files).
-- It installs and runs Metals itself through Coursier, so the server is not
-- set up through lspconfig or Mason like the others in init.lua.
-- https://github.com/scalameta/nvim-metals

vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/scalameta/nvim-metals',
}

local metals = require 'metals'

local metals_config = metals.bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
}
-- vim.lsp.start() doesn't read vim.lsp.config('*'), where blink.cmp registers
-- its completion capabilities, so hand them to Metals directly
metals_config.capabilities = require('blink.cmp').get_lsp_capabilities()

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('custom-metals', { clear = true }),
  pattern = { 'scala', 'sbt' },
  callback = function() metals.initialize_or_attach(metals_config) end,
})

vim.keymap.set('n', '<leader>cm', function() require('telescope').extensions.metals.commands() end, { desc = '[C]ode [M]etals commands' })
