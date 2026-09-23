-- ============================================================================
--  treesitter.lua : accurate syntax highlighting
--  Tree-sitter actually parses your code (instead of guessing with regexes),
--  so highlighting and auto-indent are much smarter.
--  Needs the `tree-sitter` CLI + a C compiler to build language parsers.
--  Add a language: put its name in the list below, or run :TSInstall <lang>
-- ============================================================================

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate", -- keep parsers up to date when the plugin updates
  config = function()
    -- Languages to install parsers for.
    require("nvim-treesitter").install({
      "go", "gomod", "gosum", "gowork", -- Go and its module files
      "lua", "vim", "vimdoc", "query",  -- for editing this config
      "bash", "c", "json", "yaml", "toml", "make",
      "markdown", "markdown_inline",    -- notes / READMEs
      "gitcommit", "diff",
    })

    -- Whenever a file opens, turn on tree-sitter highlighting + indentation
    -- (if we have a parser for that language; otherwise do nothing).
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("scriptorium-treesitter", { clear = true }),
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
