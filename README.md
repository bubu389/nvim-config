# The Scriptorium: Neovim cheat sheet

`<Space>` is the leader key. Press it and wait: a popup shows every shortcut.

## Essentials
| Keys | Action |
|---|---|
| `<Space>w` / `<Space>q` | Save / close window |
| `<Esc>` | Clear search highlight |
| `jk` (insert mode) | Back to normal mode |
| `<Space>e` | File explorer |
| `<Space><Space>` / `<Space>ff` | Find a file |
| `<Space>fg` | Search text in the project (needs `ripgrep`) |
| `<Space>/` | Search in the current file |
| `<Shift>h` / `<Shift>l` | Previous / next open file |
| `<Space>bd` | Close the current file |
| `y` / `p` | Copy / paste, shared with the system clipboard |
| `Alt+j` / `Alt+k` | Move line (or selected block) down / up |

## Windows & terminals
| Keys | Action |
|---|---|
| `<Ctrl>h/j/k/l` | Move between splits (also from terminals) |
| `<Space>sv` / `<Space>sh` / `<Space>sx` | Vertical split / horizontal split / close split |
| `<Space>tv` / `<Space>th` / `<Space>tf` | Terminal: right / bottom / floating (press again to hide) |
| `<Ctrl>/` | Toggle bottom terminal |
| `<Esc><Esc>` | Leave terminal mode (to scroll or copy) |

## Go
| Keys | Action |
|---|---|
| `<Space>rr` | `go run .` |
| `<Space>rf` | `go run` on this file only |
| `<Space>rt` / `<Space>rv` / `<Space>rb` | `go test` / `go vet` / `go build` (`./...`) |
| `gd` / `gr` / `gI` / `gy` | Definition / references / implementations / type definition |
| `K` | Docs for the word under the cursor |
| `<Space>ca` | Code action (quick fixes) |
| `<Space>cr` | Rename everywhere |
| `]d` / `[d` / `<Space>cd` | Next / previous error / show the error |
| `<Space>fd` | List all errors |
| (on save) | Imports are organised and the file is gofmt'ed automatically |

## Markdown
Headings, checkboxes, tables and code blocks render right in the editor as you write;
the line under the cursor shows the raw text.

| Keys | Action |
|---|---|
| `<Space>mr` | Toggle in-editor rendering |
| `<Space>mp` / `<Space>mc` | Open / close live preview in the browser (updates as you type) |
| `<Space>mo` | Outline: jump to a heading |
| `gd` | Follow a link to its heading or file |

## LaTeX
VimTeX rebuilds the PDF every time you save and shows it in Zathura. Put Zathura
beside the terminal for a side-by-side view. `texlab` completes commands and
`\cite{}` keys from your `.bib` file.

| Keys | Action |
|---|---|
| `<Space>ll` | Start / stop building on every save (opens the PDF) |
| `<Space>lv` | Jump the PDF to the line under the cursor |
| Ctrl + click (in Zathura) | Jump Neovim to that line |
| `<Space>lt` | Table of contents: jump to a section |
| `<Space>le` | Show build errors |
| `<Space>lk` | Stop building |
| `<Space>lc` | Clean up build files (`.aux`, `.log` …) |

## Writing better English
Harper checks grammar, spelling and style in British English: in Markdown, text files,
commit messages, and the comments of code files. Mistakes get a blue underline.

| Keys | Action |
|---|---|
| `<Space>ca` | On an underlined word: see fixes, or add the word to your dictionary |
| `]d` / `[d` / `<Space>cd` | Next / previous mistake / explain it |

## Claude Code
Claude's edits open as a side-by-side diff for you to accept or reject.
Open Claude with `<Space>ac`, or run `claude` in any terminal opened from Neovim
(e.g. `<Space>tv`) and type `/ide` to connect it.

| Keys | Action |
|---|---|
| `<Space>ac` / `<Space>af` | Toggle Claude (right split) / jump to it |
| `:w` or `<Space>aa` | Accept Claude's change (edit it first if you like) |
| `<Space>ad` | Reject Claude's change |
| `<Space>as` (visual) | Send the selection to Claude |
| `<Space>ab` | Add the current file to the chat |
| `<Space>ar` / `<Space>aC` | Resume a past chat / continue the last one |

## Toggles & ambience
| Keys | Action |
|---|---|
| `<Space>ub` | Parchment (light) ⇄ candlelit library (dark) |
| `<Space>uh` | Inlay type hints |
| `<Space>ur` / `<Space>uw` / `<Space>us` | Relative numbers / wrap / spell check |
| `<Space>z` | Zen study mode |
| `<Space>uC` | Try other colour schemes |

## Maintenance
- `:Lazy` updates plugins. `:Mason` manages language servers. `:checkhealth` finds problems.
- System tools (already installed): `ripgrep` + `fd` for search, `wl-clipboard` so
  yank/paste share the system clipboard, and `tree-sitter` (in `~/.local/bin`) + `gcc`
  to build syntax parsers.
