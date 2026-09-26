-- ============================================================================
--  latex.lua : writing LaTeX with a live PDF beside it
--
--   vimtex   compiles your .tex file every time you save (using latexmk)
--            and shows the PDF in Zathura. Put Zathura beside the terminal
--            for a side-by-side view. The PDF reloads itself on each save.
--
--   Forward search:  <Space>lv jumps the PDF to where your cursor is.
--   Inverse search:  Ctrl + click in Zathura jumps Neovim to that line.
--
--  The LaTeX language server (texlab) lives in lsp.lua. It gives completion
--  for commands and \cite{} keys from your .bib file.
--
--   <Space>ll   start / stop compiling on every save (opens the PDF)
--   <Space>lv   show the current line in the PDF
--   <Space>lt   table of contents: jump to a section
--   <Space>le   show compile errors
--   <Space>lc   clean up the build files (.aux, .log ...)
--   <Space>lk   stop compiling
-- ============================================================================

return {
  {
    "lervag/vimtex",
    lazy = false, -- vimtex must not be lazy-loaded (it sets itself up on startup)
    init = function()
      vim.g.vimtex_view_method = "zathura"  -- PDF viewer with forward/inverse search
      vim.g.vimtex_compiler_method = "latexmk" -- reruns pdflatex + biber as needed
      vim.g.vimtex_quickfix_open_on_warning = 0 -- only pop up the error list for errors
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- keep K for LSP hover docs
    end,
  },
}
