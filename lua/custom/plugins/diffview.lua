-- Diffview is a review UI for git diffs: a panel listing every changed file next
-- to a side-by-side diff of the selected one, over any pair of revisions. Fills
-- the gap between gitsigns (per-hunk, one buffer) and telescope's git pickers
-- (a preview pane, not a real diff).
-- https://github.com/sindrets/diffview.nvim

local plugins = {
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
}

if vim.g.have_nerd_font then
  table.insert(plugins, 'https://github.com/nvim-tree/nvim-web-devicons') -- file icons in the panel
end

vim.pack.add(plugins)

local actions = require 'diffview.actions'

-- Diffview binds <leader>b to its file panel toggle, which shadows the whole
-- <leader>b [B]uffer group for as long as a diffview tab is focused. Move it
-- under <leader>h instead, where the rest of the git keys already live.
local panel_toggle = {
  ['<leader>b'] = false,
  ['<leader>hf'] = actions.toggle_files,
}

require('diffview').setup {
  -- Highlight the changed regions within a line, not just the line itself
  enhanced_diff_hl = true,
  -- Without a Nerd Font the panel falls back to plain text markers, and
  -- diffview stops warning about the missing nvim-web-devicons
  use_icons = vim.g.have_nerd_font,
  view = {
    merge_tool = {
      -- Both parents plus the working copy, so a conflict can be resolved
      -- against what each side actually did
      layout = 'diff3_mixed',
      disable_diagnostics = true,
    },
  },
  keymaps = {
    view = panel_toggle,
    file_panel = panel_toggle,
    file_history_panel = panel_toggle,
  },
}

-- The revision a branch should be reviewed against. Prefers whatever origin
-- points its HEAD at, since that's the branch a PR would target.
local function default_base()
  local head = vim.system({ 'git', 'symbolic-ref', '--short', 'refs/remotes/origin/HEAD' }, { text = true }):wait()
  if head.code == 0 then return (vim.trim(head.stdout):gsub('^origin/', '')) end

  for _, branch in ipairs { 'main', 'master' } do
    if vim.system({ 'git', 'rev-parse', '--verify', '--quiet', branch }):wait().code == 0 then return branch end
  end

  return 'HEAD~1'
end

-- Diffview opens in its own tabpage, so closing it is the way back rather than
-- a window close.
vim.keymap.set('n', '<leader>hd', function()
  if require('diffview.lib').get_current_view() then
    vim.cmd 'DiffviewClose'
  else
    vim.cmd 'DiffviewOpen'
  end
end, { desc = 'git [d]iff of the working tree (toggle)' })

-- `base...HEAD` diffs against the merge base, so commits that landed on the
-- base branch after this one forked off don't show up as changes.
vim.keymap.set('n', '<leader>hD', function()
  vim.ui.input({ prompt = 'DiffviewOpen ', default = default_base() .. '...HEAD' }, function(rev)
    if rev and rev ~= '' then vim.cmd('DiffviewOpen ' .. rev) end
  end)
end, { desc = 'git [D]iff against a revision' })

vim.keymap.set('n', '<leader>hh', '<Cmd>DiffviewFileHistory %<CR>', { desc = 'git [h]istory of this file' })
vim.keymap.set('n', '<leader>hH', '<Cmd>DiffviewFileHistory<CR>', { desc = 'git [H]istory of the whole repo' })
