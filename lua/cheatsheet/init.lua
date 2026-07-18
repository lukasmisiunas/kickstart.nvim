local M = {}

local config = {
  file = vim.fs.joinpath(vim.fn.stdpath 'config', 'cheatsheet.md'),
}

-- Descriptions are separated from the key by an em dash, en dash, hyphen or
-- colon. Matching those in a Lua character class is unreliable because the
-- dashes are multi-byte, so strip them one candidate at a time.
local separators = { '—', '–', '-', ':' }

local function strip_separator(text)
  text = text:gsub('^%s+', '')
  for _, separator in ipairs(separators) do
    if text:sub(1, #separator) == separator then
      text = text:sub(#separator + 1)
      break
    end
  end
  return (text:gsub('^%s+', ''))
end

local function parse(path)
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok then return nil end

  local shortcuts = {}
  local section = ''

  for _, line in ipairs(lines) do
    local heading = line:match '^##%s+(.+)%s*$'
    if heading then
      section = heading
    else
      local key, rest = line:match '^%s*[-*]%s+`([^`]+)`%s*(.*)$'
      if key then table.insert(shortcuts, { section = section, key = key, description = strip_separator(rest) }) end
    end
  end

  return shortcuts
end

local function pad(text, width) return text .. string.rep(' ', width - vim.fn.strdisplaywidth(text)) end

local function make_finder(shortcuts)
  local widest_section = 0
  local widest_key = 0
  for _, shortcut in ipairs(shortcuts) do
    widest_section = math.max(widest_section, vim.fn.strdisplaywidth(shortcut.section))
    widest_key = math.max(widest_key, vim.fn.strdisplaywidth(shortcut.key))
  end

  -- Columns are padded here rather than via the displayer's `width` option:
  -- that option resolves widths against the running picker's layout, which
  -- does not exist yet while the finder is being built.
  local displayer = require('telescope.pickers.entry_display').create {
    separator = '  ',
    items = { {}, {}, { remaining = true } },
  }

  return require('telescope.finders').new_table {
    results = shortcuts,
    entry_maker = function(shortcut)
      return {
        value = shortcut,
        -- Fuzzy matching runs against the ordinal, so include every field to
        -- make the section and description searchable alongside the key.
        ordinal = table.concat({ shortcut.section, shortcut.key, shortcut.description }, ' '),
        display = function()
          return displayer {
            { pad(shortcut.section, widest_section), 'TelescopeResultsIdentifier' },
            { pad(shortcut.key, widest_key), 'TelescopeResultsConstant' },
            shortcut.description,
          }
        end,
      }
    end,
  }
end

function M.open()
  local shortcuts = parse(config.file)

  if not shortcuts then
    vim.notify('Cheatsheet: cannot read ' .. config.file, vim.log.levels.ERROR)
    return
  end

  if vim.tbl_isempty(shortcuts) then
    vim.notify('Cheatsheet: no shortcuts found in ' .. config.file, vim.log.levels.WARN)
    return
  end

  local actions = require 'telescope.actions'

  require('telescope.pickers')
    .new(require('telescope.themes').get_dropdown { previewer = false }, {
      prompt_title = 'Cheatsheet',
      finder = make_finder(shortcuts),
      sorter = require('telescope.config').values.generic_sorter {},
      attach_mappings = function(prompt_buffer)
        -- The entries are reference material, not files: selecting one should
        -- dismiss the picker rather than trying to open anything.
        actions.select_default:replace(function() actions.close(prompt_buffer) end)
        return true
      end,
    })
    :find()
end

function M.setup(options)
  config = vim.tbl_extend('force', config, options or {})
  vim.api.nvim_create_user_command('Cheatsheet', M.open, { desc = 'Search the shortcut cheatsheet' })
  vim.keymap.set('n', '<leader>?', M.open, { desc = '[?] Cheatsheet' })
end

return M
