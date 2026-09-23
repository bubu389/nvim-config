-- ============================================================================
--  ~ THE SCRIPTORIUM ~   a small, commented Neovim config for university
-- ============================================================================
--
--  How this config is laid out:
--
--    init.lua                  <- you are here. Loads everything else, in order.
--    lua/config/options.lua    <- editor settings (line numbers, tabs, etc.)
--    lua/config/keymaps.lua    <- general shortcuts that need no plugins
--    lua/config/autocmds.lua   <- small automatic behaviours ("when X, do Y")
--    lua/config/lazy.lua       <- installs the plugin manager (lazy.nvim)
--    lua/plugins/*.lua         <- one file per group of plugins
--
--  Every file in lua/plugins/ is picked up automatically, so to add a plugin
--  you just create a new file there (or add to an existing one).
--
--  Useful commands:
--    :Lazy        open the plugin manager (update / clean plugins)
--    :Mason       open the tool installer (language servers like gopls)
--    :checkhealth check that everything is installed correctly
--
--  Press <Space> and wait a moment: a popup lists every shortcut.
-- ============================================================================

-- The leader key is a "prefix" for custom shortcuts. We use Space.
-- This MUST be set before plugins load, so plugin keymaps pick it up.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- We have a Nerd Font installed (JetBrainsMono Nerd Font), so icons are safe.
vim.g.have_nerd_font = true

require("config.options")  -- editor settings
require("config.keymaps")  -- plugin-free shortcuts
require("config.autocmds") -- automatic behaviours
require("config.lazy")     -- plugin manager + all plugins
