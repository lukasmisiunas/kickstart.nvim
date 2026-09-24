# Cheatsheet

Shortcuts I want on hand. Format: `## Section` headings, one shortcut per
bullet, key in backticks, then a separator and the description.

## Navigation

- `f)` — Jump to the next `)` on the line, matched or not (`;` repeats, `,` reverses)
- `t)` — Same, but stop just before it
- `%` — Jump to matching bracket; with no bracket under the cursor it scans forward on the line for one first, so it also lands on the `)` of `onClose()`
- `[(` — Jump to previous unmatched `(`
- `])` — Jump to next unmatched `)`; this is for jumping *out* of the parens you are inside, so it skips pairs that are already closed
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
- `<leader>yp` — Copy the current file's path to the clipboard, relative to the cwd (works on the node under the cursor in neo-tree too)
- `<leader>yP` — Same, but the absolute path
- `y` — In neo-tree, copy the highlighted file's name (replaces neo-tree's internal copy-a-file clipboard; `c` still copies a file)
- `Y` / `gY` — In neo-tree, copy the highlighted path (relative / absolute)

## Search

- `<leader>sf` — Find files; the prompt takes fzf syntax: `!test` excludes, `'exact`, `^src`, `.tsx$`, `go$ | rb$`
- `<leader>sg` — Live grep; here the prompt is an `rg` pattern, so those tokens match literally
- `<C-Space>` — Freeze the live grep results into a fuzzy list, where the tokens above work (`<C-Enter>` too, in terminals that can send it)
- `.ignore` — A file at the project root that both `fd` and `rg` honor: keeps paths out of every picker without touching `.gitignore`

## Code

- `<leader>cr` — Restart the language servers attached to this buffer (tsserver drifting after a branch switch)

## Macros

- `qa` — Start recording into register `a` (any letter works)
- `q` — Stop recording
- `@a` — Run the macro in register `a`
- `@@` — Run the last macro again
- `10@a` — Run it 10 times; it stops early on the first error, e.g. when a `f)` finds nothing
- `qA` — Append to register `a` instead of overwriting it
- `:'<,'>normal @a` — Run the macro once per line over a visual selection
- `"ap` — Paste the macro out as text to edit it, then `"ay$` to yank the fixed line back into `a`

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
