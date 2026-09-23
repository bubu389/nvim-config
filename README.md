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
