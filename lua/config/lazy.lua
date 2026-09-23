-- ============================================================================
--  lazy.lua : installs and starts lazy.nvim, the plugin manager
--  The first time you open Neovim it downloads itself and every plugin.
--  Afterwards, run :Lazy to update/clean plugins.
-- ============================================================================

-- Where lazy.nvim lives on disk (~/.local/share/nvim/lazy/lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If it isn't there yet, clone it from GitHub.
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n" .. out, "ErrorMsg" } }, true, {})
    return
  end
end

-- Make Neovim able to find lazy.nvim.
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Load every file in lua/plugins/ as a plugin spec.
  spec = { { import = "plugins" } },

  -- Colourscheme used while plugins install for the first time.
  install = { colorscheme = { "melange", "habamax" } },

  -- Don't pop up a message every time a config file changes.
  change_detection = { notify = false },

  -- Quietly check for plugin updates in the background (see :Lazy).
  checker = { enabled = true, notify = false },

  ui = { border = "rounded" },
})
