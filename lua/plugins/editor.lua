-- ============================================================================
--  editor.lua : small editing helpers
-- ============================================================================

return {
  -- Select/jump around functions and classes using tree-sitter, so it
  -- understands "def main():" or "fun main() {" as one unit, not just braces.
  --   af / if   around / inside function   (af = signature + body, if = body only)
  --   ac / ic   around / inside class
  -- Works in visual mode (select it) and operator-pending mode (e.g. daf = delete a function).
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@function.outer"] = "V",
            ["@class.outer"] = "V",
          },
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local map = vim.keymap.set
      local function textobj(capture)
        return function() select.select_textobject(capture, "textobjects") end
      end
      map({ "x", "o" }, "af", textobj("@function.outer"), { desc = "Around function" })
      map({ "x", "o" }, "if", textobj("@function.inner"), { desc = "Inside function" })
      map({ "x", "o" }, "ac", textobj("@class.outer"), { desc = "Around class" })
      map({ "x", "o" }, "ic", textobj("@class.inner"), { desc = "Inside class" })
    end,
  },

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
