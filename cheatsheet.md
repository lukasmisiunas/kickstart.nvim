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
- `:e!` — Discard unsaved changes, reloading the file from disk
- `:earlier 1f` — Undo back to the last save (`:later 1f` to come back)

## Splits

- `<C-w>>` — Widen the current split (takes a count, e.g. `10<C-w>>`)
- `<C-w><` — Narrow the current split
- `<C-w>+` — Make the current split taller
- `<C-w>-` — Make the current split shorter
- `<C-w>=` — Even out all split sizes
- `<C-w>|` — Maximise the current split's width
- `<C-w>_` — Maximise the current split's height

## Files

- `H` — Reveal hidden entries in neo-tree: what `.gitignore` covers, plus `.git`

## Code

- `<leader>cr` — Restart the language servers attached to this buffer (tsserver drifting after a branch switch)

## Terminal

- `<C-\>` — Toggle terminal in a floating window (keeps the session alive)
- `<Esc><Esc>` — Leave terminal mode (back to normal mode)

## Git

- `<leader>hd` — Toggle the diff view of the working tree
- `<leader>hD` — Diff against a revision (prompts, defaults to the base branch)
- `<leader>hh` — History of the current file, commit by commit
- `<leader>hH` — History of the whole repo
- `<leader>gs` — Changed files (Telescope)
- `<leader>gc` — Commits (Telescope)

### Inside the diff view

- `<Tab>` / `<S-Tab>` — Next / previous changed file
- `<leader>hf` — Toggle the file panel
- `g<C-x>` — Cycle through the layouts (side-by-side, stacked, …)
- `-` — Stage or unstage the file under the cursor (file panel)
- `X` — Restore the file under the cursor to its state on the left side
