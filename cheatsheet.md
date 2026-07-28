# Cheatsheet

Shortcuts I want on hand. Format: `## Section` headings, one shortcut per
bullet, key in backticks, then a separator and the description.

## Navigation

- `%` — Jump to matching bracket
- `[(` — Jump to previous unmatched `(`
- `])` — Jump to next unmatched `)`
- `[{` — Jump to previous unmatched `{`
- `]}` — Jump to next unmatched `}`
- `}` — Jump to next blank line (paragraph forward)
- `{` — Jump to previous blank line (paragraph back)
- `]m` — Jump to next method start
- `[m` — Jump to previous method start
- `gd` — Goto definition of symbol under cursor
- `gO` — Document symbols (jump to symbol in file)
- `<C-o>` — Jump back to previous location
- `<C-i>` — Jump forward again

## Buffers

- `<leader>bd` — Close current buffer
- `<leader>bo` — Close all buffers except the current one

## Splits

- `<C-w>>` — Widen the current split (takes a count, e.g. `10<C-w>>`)
- `<C-w><` — Narrow the current split
- `<C-w>+` — Make the current split taller
- `<C-w>-` — Make the current split shorter
- `<C-w>=` — Even out all split sizes
- `<C-w>|` — Maximise the current split's width
- `<C-w>_` — Maximise the current split's height

## Terminal

- `<leader>tt` — Toggle terminal in a right-hand split (keeps the session alive)
- `<Esc><Esc>` — Leave terminal mode (back to normal mode)
