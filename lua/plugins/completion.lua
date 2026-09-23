-- ============================================================================
--  completion.lua : blink.cmp, the autocomplete popup
--  Suggestions come from the language server, file paths, snippets and words
--  already in the file.
--
--    <Tab> / <S-Tab>   move down / up the list
--    <CR> (Enter)      accept the highlighted suggestion
--    <C-Space>         open the menu manually / toggle docs
--    <C-e>             close the menu
-- ============================================================================

return {
  "saghen/blink.cmp",
  version = "1.*", -- use a release tag so a prebuilt fast binary is downloaded
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      -- Don't pre-select the first item, so Enter still makes a newline
      -- unless you've actually chosen something with <Tab>.
      list = { selection = { preselect = false, auto_insert = true } },
      menu = { border = "rounded" },
      documentation = { auto_show = true, auto_show_delay_ms = 300, window = { border = "rounded" } },
    },
    signature = { enabled = true, window = { border = "rounded" } }, -- show args while typing a call
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
