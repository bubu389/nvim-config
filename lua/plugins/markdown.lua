-- ============================================================================
--  markdown.lua : nicer Markdown writing
--
--   render-markdown.nvim  draws headings, checkboxes, tables, code blocks and
--                         quotes right inside the editor as you write.
--                         The raw text comes back on the line your cursor is on.
--   live-preview.nvim     opens the file in your browser and updates it live
--                         as you type (scroll follows the cursor). Put the
--                         browser beside the terminal for a side-by-side view.
--
--  The Markdown language server (marksman) lives in lsp.lua.
--
--   <Space>mr   toggle in-editor rendering
--   <Space>mp   open live browser preview
--   <Space>mc   close live browser preview
--   <Space>mo   outline: jump to a heading
-- ============================================================================

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      completions = { lsp = { enabled = true } }, -- complete callouts / checkboxes
      heading = {
        sign = false,                  -- keep the gutter clean
        width = "block",               -- heading background only as wide as the text
        left_pad = 1,
        right_pad = 2,
      },
      code = {
        sign = false,
        width = "block",               -- code block background fits the code
        right_pad = 2,
        border = "thick",
      },
      checkbox = { checked = { scope_highlight = "@markup.strikethrough" } }, -- strike done tasks
      pipe_table = { preset = "round" }, -- rounded table borders
      latex = { enabled = false },       -- needs an extra tool (utftex); off for now
    },
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle rendering" },
    },
  },

  {
    "brianhuster/live-preview.nvim",
    cmd = "LivePreview",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      picker = "snacks.picker",
      sync_scroll = true, -- browser scrolls along with your cursor
      -- Serve from the file's own folder, so it works even when the file is
      -- outside the folder Neovim was opened in (otherwise: 404 at /nil).
      dynamic_root = true,
    },
    config = function(_, opts)
      require("livepreview.config").set(opts)
    end,
    keys = {
      { "<leader>mp", "<cmd>LivePreview start<cr>", ft = "markdown", desc = "Live preview in browser" },
      { "<leader>mc", "<cmd>LivePreview close<cr>", ft = "markdown", desc = "Close live preview" },
    },
  },

  -- Outline: pick a heading and jump to it (headings come from marksman).
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>mo", function() Snacks.picker.lsp_symbols() end, ft = "markdown", desc = "Outline (jump to heading)" },
    },
  },
}
