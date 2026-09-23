-- ============================================================================
--  keymaps.lua : shortcuts that don't depend on any plugin
--  Plugin shortcuts (files, terminals, LSP...) live next to their plugin in
--  lua/plugins/. Press <Space> and wait to see them all in a popup.
--
--  Reading a keymap:  map(MODE, KEYS, ACTION, { desc = "..." })
--    MODE: "n" normal, "i" insert, "v" visual, "t" terminal
--    <leader> = Space,  <C-x> = Ctrl+x,  <S-x> = Shift+x,  <CR> = Enter
-- ============================================================================

local map = vim.keymap.set

-- ── General ─────────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>quitall<CR>", { desc = "Quit Neovim" })
map("i", "jk", "<Esc>", { desc = "Leave insert mode (quick escape)" })

-- ── Moving between windows (splits) ─────────────────────────────────────────
-- Ctrl + h/j/k/l moves left/down/up/right. Works from terminals too.
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to lower window" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to upper window" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window" })

-- ── Creating & resizing splits ──────────────────────────────────────────────
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertically" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontally" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close this split" })
map("n", "<leader>s=", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Taller window" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Shorter window" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Narrower window" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Wider window" })

-- ── Terminal mode ───────────────────────────────────────────────────────────
-- Inside a terminal, keys go to the shell. Double-Esc returns you to Neovim
-- (normal mode) so you can scroll, copy text, or switch windows.
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ── Buffers (open files) ────────────────────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- ── Editing helpers ─────────────────────────────────────────────────────────
-- Alt+j / Alt+k move lines down/up, re-indenting them as they go.
-- In visual mode the whole selection moves and STAYS selected (the "gv"),
-- so you can keep pressing Alt+j/k to slide the block where you want it.
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
-- Keep the selection after indenting so you can press > repeatedly.
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
-- Keep the cursor centred when jumping half pages / through search results.
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centred)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centred)" })
map("n", "n", "nzzzv", { desc = "Next match (centred)" })
map("n", "N", "Nzzzv", { desc = "Previous match (centred)" })

-- ── Diagnostics (errors / warnings) ─────────────────────────────────────────
-- Built in already: ]d / [d jump to next / previous diagnostic.
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show error under cursor" })
