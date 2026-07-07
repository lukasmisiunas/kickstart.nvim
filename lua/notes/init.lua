local M = {}

local config = {
  dir = '~/notes',
}

local function list_notes(dir)
  local files = {}
  for name, type in vim.fs.dir(dir) do
    if type == 'file' and name:match '%.md$' then table.insert(files, name) end
  end
  return files
end

local function create_notes_buffer(notes)
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buffer })
  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, notes)
  return buffer
end

local function create_window(buffer)
  local editorwidth = vim.o.columns
  local editorheight = vim.o.lines
  local width = editorwidth - 10
  local height = editorheight
  local window = vim.api.nvim_open_win(buffer, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((editorwidth - width) / 2),
    row = math.floor((editorheight - height) / 2),
    style = 'minimal',
    border = 'rounded',
  })
  return window
end

function M.open()
  local notes_folder = vim.fs.normalize(config.dir)
  local notes = list_notes(notes_folder)
  local buffer = create_notes_buffer(notes)
  local window = create_window(buffer)
  vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(window, true) end, { buf = buffer })
  vim.keymap.set('n', '<CR>', function()
    local row = vim.api.nvim_win_get_cursor(window)[1]
    local note = notes[row]

    if not note then return end

    local note_path = vim.fs.joinpath(notes_folder, note)
    vim.api.nvim_win_close(window, true)
    vim.cmd.edit(vim.fn.fnameescape(note_path))
  end, { buf = buffer })
end

function M.setup(options)
  config = vim.tbl_extend('force', config, options or {})
  vim.api.nvim_create_user_command('Notes', M.open, {})
end

return M
