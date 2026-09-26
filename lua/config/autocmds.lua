-- ============================================================================
--  autocmds.lua : things that happen automatically on certain events
--  An "autocommand" = "when EVENT happens (for FILES), run this function".
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("scriptorium", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Briefly flash the text you just yanked (copied) so you can see what you got.
autocmd("TextYankPost", {
  group = augroup,
  callback = function() vim.hl.on_yank({ timeout = 200 }) end,
})

-- Go uses real TAB characters for indentation (gofmt insists on it).
autocmd("FileType", {
  group = augroup,
  pattern = { "go", "gomod", "gowork", "make" },
  callback = function() vim.opt_local.expandtab = false end,
})

-- Turn on wrapping + spell check for prose (notes, READMEs, commit messages).
autocmd("FileType", {
  group = augroup,
  pattern = { "markdown", "text", "gitcommit", "tex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Reopen a file at the line you were on last time.
autocmd("BufReadPost", {
  group = augroup,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lines = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Keep splits equally sized when the terminal window itself is resized.
autocmd("VimResized", {
  group = augroup,
  command = "tabdo wincmd =",
})

-- Close helper windows (help, quickfix, etc.) with just "q".
autocmd("FileType", {
  group = augroup,
  pattern = { "help", "qf", "man", "checkhealth", "lspinfo" },
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
  end,
})
