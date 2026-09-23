-- ============================================================================
--  claude.lua : Claude Code inside Neovim
--  Connects the `claude` CLI to Neovim (like the VS Code extension), so:
--    - Claude's edits open as a side-by-side diff you accept or reject
--    - Claude sees the file you have open and what you've selected
--
--  Two ways to use it:
--    <Space>ac      open Claude in a split on the right (connects by itself)
--    any terminal   run `claude` in a terminal opened from Neovim (e.g. <Space>tv),
--                   then type /ide and pick Neovim
--
--  Reviewing a change Claude proposes:
--    :w or <Space>aa   accept (you can edit Claude's version first)
--    <Space>ad         reject
-- ============================================================================

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  lazy = false, -- start the connection at launch, so /ide works from any terminal
  opts = {
    terminal = {
      split_side = "right",
      split_width_percentage = 0.4,
    },
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume a past chat" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last chat" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Pick Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add this file to the chat" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
    { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file to the chat", ft = { "snacks_picker_list", "netrw" } },
    -- Reviewing Claude's proposed changes
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude's change" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject Claude's change" },
  },
}
