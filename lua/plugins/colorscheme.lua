-- ============================================================================
--  colorscheme.lua : Melange, tuned for a "dark academia" feel
--  Warm, bookish colours: worn leather browns, sepia ink, old gold,
--  burgundy and muted library greens.
--    light mode -> aged parchment pages with sepia ink
--    dark mode  -> a candlelit library: brown-black wood and cream text (default)
--  Toggle between them with <Space>ub.
--  To start in light mode instead, set  opt.background = "light"  in options.lua.
--  Browse other installed schemes with <Space>uC.
-- ============================================================================

-- Our own accent colours, used for the extra touches below.
local accents = {
  light = { title = "#7D2A2F", key = "#A06D00", linenr = "#7D2A2F" }, -- burgundy + ochre ink
  dark  = { title = "#EBC06D", key = "#E49B5D", linenr = "#EBC06D" }, -- old gold + candle amber
}

return {
  "savq/melange-nvim",
  lazy = false,    -- load at startup...
  priority = 1000, -- ...before every other plugin, so colours are ready
  config = function()
    -- Melange's light mode is a plain grey-white. Re-tint its background
    -- colours to aged parchment before the colourscheme is loaded.
    local light = require("melange/palettes/light").a
    light.bg = "#F2E8D5"    -- the page
    light.float = "#E9DCC3" -- popups / sidebars (slightly older paper)
    light.sel = "#DFD0B4"   -- current line & selections

    -- Extra touches, re-applied every time the scheme loads
    -- (including when switching light <-> dark).
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "melange",
      group = vim.api.nvim_create_augroup("scriptorium-colors", { clear = true }),
      callback = function()
        local p = require("melange/palettes/" .. vim.o.background).a -- greys/browns
        local x = accents[vim.o.background]
        local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end

        hl("CursorLineNr", { fg = x.linenr, bold = true })             -- current line number
        hl("SnacksDashboardHeader", { fg = x.title })                  -- the book art
        hl("SnacksDashboardKey", { fg = x.key, bold = true })          -- shortcut letters
        hl("SnacksDashboardIcon", { fg = p.ui })
        hl("SnacksDashboardDesc", { fg = p.fg })
        hl("SnacksDashboardFooter", { fg = p.com, italic = true })     -- the quote
        hl("Comment", { fg = p.com, italic = true })                   -- comments like marginalia
      end,
    })
    vim.cmd.colorscheme("melange")
  end,
}
