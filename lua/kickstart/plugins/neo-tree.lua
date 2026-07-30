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

-- Tree of just the files changed vs HEAD. `toggle` rather than `reveal` because the
-- git_status window has no `\` close mapping the way the filesystem one does, so this
-- key is the only way back out.
vim.keymap.set('n', '<leader>gt', '<Cmd>Neotree toggle git_status<CR>', { desc = 'NeoTree [G]it [T]ree', silent = true })

require('neo-tree').setup {
  window = {
    position = 'left',
  },
  -- Neo-tree runs `git status --ignored=traditional`, which makes git descend into
  -- ignored directories instead of stopping at the pattern that ignores them. In a
  -- repo with node_modules that means walking ~1.2M files: measured 50s for
  -- `:Neotree git_status` (26s in git + 24s parsing the result into a table), all of
  -- it blocking, since that source calls git synchronously. `--ignored=matching`
  -- collapses ignored directories into one entry -- same repo drops to 0.14s.
  -- hide_gitignored still works: neo-tree resolves a path's status by walking up to
  -- its parents, so files under a `!` directory are still treated as ignored.
  event_handlers = {
    {
      event = 'before_git_status',
      handler = function(args)
        -- git rejects `--ignored=matching` together with `--untracked-files=no`, which is
        -- what neo-tree uses for its fast first pass over a new worktree. That pass doesn't
        -- need the ignored list anyway (it comes from a separate `git ls-files` job), so
        -- drop ignored entirely there.
        local skip_untracked = vim.tbl_contains(args.status_args, '--untracked-files=no')
        for i, arg in ipairs(args.status_args) do
          if arg:match '^%-%-ignored=' then
            args.status_args[i] = skip_untracked and '--ignored=no' or '--ignored=matching'
          end
        end
      end,
    },
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
