-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local plugins = {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

if vim.g.have_nerd_font then
  table.insert(plugins, 'https://github.com/nvim-tree/nvim-web-devicons') -- not strictly required, but recommended
end

vim.pack.add(plugins)

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

-- Swap the tree between the left and right side of the window
vim.keymap.set('n', '<leader>\\', function()
  local state = require('neo-tree.sources.manager').get_state 'filesystem'
  -- current_position is nil while the tree is closed, so fall back to the configured side
  local current = state.current_position or state.window.position or 'left'
  vim.cmd('Neotree ' .. (current == 'left' and 'right' or 'left') .. ' reveal')
end, { desc = 'NeoTree swap side', silent = true })

require('neo-tree').setup {
  window = {
    position = 'left',
  },
  filesystem = {
    -- Don't let neo-tree hijack `nvim <dir>`. Plain netrw is a normal buffer, so
    -- global keymaps like <leader>sf work without having to leave it first.
    hijack_netrw_behavior = 'disabled',
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
}
