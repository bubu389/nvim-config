-- ============================================================================
--  editor.lua : small editing helpers
-- ============================================================================

return {
  -- Auto-close brackets and quotes: type ( and get () with the cursor inside.
  {
    "nvim-mini/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Surround text with brackets/quotes:
  --   sa + motion + char   add      e.g. saiw"  -> wraps a word in "quotes"
  --   sd + char            delete   e.g. sd"    -> removes surrounding quotes
  --   sr + old + new       replace  e.g. sr"'   -> "x" becomes 'x'
  {
    "nvim-mini/mini.surround",
    keys = { { "sa", mode = { "n", "x" } }, "sd", "sr" },
    opts = {},
  },

  -- Highlight TODO / FIXME / NOTE comments, and list them with <Space>ft.
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Find TODO comments" },
    },
  },
}
