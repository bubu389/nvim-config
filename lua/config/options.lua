-- ============================================================================
--  options.lua : how the editor looks and behaves
--  Tip: type  :help 'optionname'  (with the quotes) to read about any option.
-- ============================================================================

local opt = vim.opt -- shorthand so the lines below stay short

-- ── Line numbers ────────────────────────────────────────────────────────────
opt.number = true          -- show the line number of every line
opt.relativenumber = true  -- show OTHER lines as distance from the cursor,
                           -- so "5j" / "12k" jumps are easy to count.
                           -- Toggle with <Space>ur. Set to false to disable.

-- ── Current line highlight ──────────────────────────────────────────────────
opt.cursorline = true      -- highlight the row the cursor is on
opt.cursorlineopt = "both" -- highlight both the line AND its line number

-- ── Cursor shape ────────────────────────────────────────────────────────────
-- Each part is "modes:shape-blinking". Blink times are in milliseconds.
opt.guicursor = table.concat({
  "n-v-c-sm:block-blinkwait300-blinkon500-blinkoff500", -- normal/visual/command: blinking block
  "i-ci-ve:ver25",                                    -- insert: thin steady bar
  "r-cr-o:hor20",                                     -- replace/pending operator: underline
  "t:block-blinkon500-blinkoff500-TermCursor",        -- inside terminals: blinking block
}, ",")

-- ── Colours ─────────────────────────────────────────────────────────────────
opt.termguicolors = true   -- use full 24-bit colour (needed by colourschemes)
opt.background = "dark"    -- start in dark mode, easier on the eyes (toggle with <Space>ub)

-- ── Indentation ─────────────────────────────────────────────────────────────
-- Go uses real TAB characters (gofmt enforces it); see autocmds.lua.
-- For every other language we default to 4 spaces.
opt.tabstop = 4            -- a TAB character looks 4 columns wide
opt.shiftwidth = 4         -- >> and << indent by 4 columns
opt.softtabstop = 4        -- pressing <Tab> in insert mode moves 4 columns
opt.expandtab = true       -- insert spaces instead of TAB characters
opt.smartindent = true     -- auto-indent new lines sensibly
opt.breakindent = true     -- wrapped lines keep their indentation

-- ── Searching ───────────────────────────────────────────────────────────────
opt.ignorecase = true      -- /hello also finds "Hello"...
opt.smartcase = true       -- ...unless you type a capital letter yourself
opt.hlsearch = true        -- highlight all matches (<Esc> clears them)
opt.incsearch = true       -- jump to matches while you are still typing
opt.inccommand = "split"   -- live preview of :s/find/replace/ in a split

-- ── Windows & splits ────────────────────────────────────────────────────────
opt.splitright = true      -- vertical splits open on the right
opt.splitbelow = true      -- horizontal splits open below
opt.laststatus = 3         -- one status line at the bottom for all windows
opt.winborder = "rounded"  -- rounded borders on floating windows (hover docs etc.)

-- ── Scrolling & view ────────────────────────────────────────────────────────
opt.scrolloff = 8          -- keep 8 lines visible above/below the cursor
opt.sidescrolloff = 8      -- same, but left/right
opt.wrap = false           -- don't wrap long lines (toggle with <Space>uw)
opt.signcolumn = "yes"     -- always show the gutter (git/error signs) so text
                           -- doesn't jump sideways when a sign appears
opt.showmode = false       -- the status line already shows the mode
opt.list = true            -- show invisible characters, using these symbols:
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
                           -- (tabs are shown as blank space to keep Go clean;
                           --  trailing spaces are shown as dots)
opt.fillchars = { eob = " " } -- hide the "~" on empty lines past end of file

-- ── Quality of life ─────────────────────────────────────────────────────────
opt.mouse = "a"            -- allow the mouse (click, scroll, resize splits)
-- Share the system clipboard: anything you yank (y) or delete (d/x) can be
-- pasted in other apps with Ctrl+V, and anything you copy elsewhere can be
-- pasted here with p. Uses wl-clipboard (Wayland) or xclip (X11).
-- Set after startup (vim.schedule) because finding the clipboard tool can
-- otherwise slow down opening Neovim.
vim.schedule(function() opt.clipboard = "unnamedplus" end)
-- Persistent undo: every file's undo history is saved to disk, so you can
-- still undo (u) after closing and reopening a file, even days later.
opt.undofile = true        -- save undo history to a file
opt.undodir = vim.fn.stdpath("state") .. "/undo" -- ~/.local/state/nvim/undo
opt.undolevels = 10000     -- how many changes to remember per file
vim.fn.mkdir(vim.o.undodir, "p") -- create the folder if it doesn't exist yet
opt.swapfile = false       -- no .swp files cluttering things
opt.confirm = true         -- ask "save changes?" instead of refusing to quit
opt.updatetime = 250       -- faster CursorHold (used by LSP highlights)
opt.timeoutlen = 300       -- ms to wait for the next key in a shortcut
opt.completeopt = { "menu", "menuone", "noselect" } -- completion menu behaviour
opt.pumheight = 10         -- max items shown in the completion popup
opt.virtualedit = "block"  -- in visual-block mode, allow going past line end
opt.spelllang = { "en_gb", "en_us" } -- used when spelling is on (<Space>us)
