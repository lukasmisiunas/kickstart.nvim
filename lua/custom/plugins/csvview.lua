-- Csvview lines up the columns of .csv and .tsv files with virtual text, so a
-- table reads as a table without the file itself being rewritten.
-- https://github.com/hat0uma/csvview.nvim

vim.pack.add { 'https://github.com/hat0uma/csvview.nvim' }

require('csvview').setup {
  view = {
    -- Draw │ between columns rather than just padding them
    display_mode = 'border',
  },
}

-- Turn the view on as soon as a table is opened
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'csv', 'tsv' },
  callback = function(event) require('csvview').enable(event.buf) end,
})

vim.keymap.set('n', '<leader>tc', '<Cmd>CsvViewToggle<CR>', { desc = '[T]oggle [C]SV column view' })
