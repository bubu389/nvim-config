-- ============================================================================
--  ui.lua : status line, shortcut helper, git signs and ambience
-- ============================================================================

return {
  -- ── lualine: the status line at the bottom ────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",                              -- follow the colourscheme
        globalstatus = true,                         -- one bar for all windows
        component_separators = { left = "·", right = "·" },
        section_separators = { left = "", right = "" }, -- rounded ends
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        -- left side
        lualine_a = { { "mode", icon = "" } },           -- current mode, with a book icon
        lualine_b = { "branch", "diff" },           -- git branch + changes
        lualine_c = { { "filename", path = 1 } },    -- path relative to project
        -- right side
        lualine_x = { "diagnostics", "filetype" },
        lualine_y = { "progress" },                  -- % through the file
        lualine_z = { "location" },                  -- line:column
      },
    },
  },

  -- ── which-key: press <Space> and wait, a popup lists what you can press ───
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 300,
      -- Names for the groups of <leader> shortcuts.
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>r", group = "run (Go)" },
        { "<leader>s", group = "split" },
        { "<leader>t", group = "terminal" },
        { "<leader>u", group = "ui toggles" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Shortcuts for this buffer" },
    },
  },

  -- ── gitsigns: shows added/changed/deleted lines in the gutter ─────────────
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function map(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = buf, desc = desc })
        end
        map("]h", function() gs.nav_hunk("next") end, "Next git change")
        map("[h", function() gs.nav_hunk("prev") end, "Previous git change")
        map("<leader>gp", gs.preview_hunk, "Preview this change")
        map("<leader>gr", gs.reset_hunk, "Undo this change (reset hunk)")
        map("<leader>gb", function() gs.blame_line({ full = true }) end, "Who wrote this line?")
        map("<leader>gd", gs.diffthis, "Diff file against last commit")
      end,
    },
  },

  -- ── drop.nvim: autumn leaves and quill feathers drifting past ─────────────
  -- Shown on the start screen, and as a screensaver after 10 idle minutes.
  -- "library" is our own theme (defined below). Built-in ones to try:
  -- "leaves", "coffee", "stars", "medieval", "nocturnal", "mystical"...
  {
    "folke/drop.nvim",
    event = "VimEnter",
    config = function(_, opts)
      -- Register a custom theme. Emoji keep their own colours; the small
      -- dots/sparkles are dust motes in lamplight and use the colours listed.
      require("drop.themes").library = {
        symbols = { "🍂", "🍁", "🪶", "·", "•", "✦", "·" },
        colors = { "#EBC06D", "#E49B5D", "#BD8183", "#C1A78E", "#8B7449" },
      }
      require("drop").setup(opts)
    end,
    opts = {
      theme = "library",
      max = 25,                          -- how many drops at once (keep it calm)
      interval = 150,                    -- ms between animation frames
      screensaver = 1000 * 60 * 10,      -- idle time before it starts (ms)
      filetypes = { "snacks_dashboard" }, -- only animate on the dashboard
    },
  },
}
