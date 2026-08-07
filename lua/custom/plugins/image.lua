-- Snacks' image viewer renders images with the kitty graphics protocol, so
-- opening a png shows the picture instead of its bytes. Also previews images
-- referenced from markdown, and renders LaTeX math.
-- https://github.com/folke/snacks.nvim/blob/main/docs/image.md

vim.pack.add { 'https://github.com/folke/snacks.nvim' }

require('snacks').setup {
  image = {
    enabled = true,
    -- iTerm2 speaks the kitty protocol (since 3.5.6) but isn't in snacks'
    -- detection list, so it has to be told to try anyway.
    force = true,
    -- Rendering math needs a LaTeX toolchain that isn't installed; without
    -- this every markdown buffer with math in it warns about the missing one.
    math = { enabled = false },
  },
}
