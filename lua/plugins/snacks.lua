-- ============================================================================
--  snacks.lua : folke/snacks.nvim, a "bag of small tools" in one plugin
--  Using one well-made plugin for many jobs keeps this config small.
--  Here it provides:
--    dashboard  - the open-book start screen
--    explorer   - file tree sidebar                       <Space>e
--    picker     - fuzzy finder for files / text / etc.    <Space>f...
--    terminal   - floating / split terminals               <Space>t...
--    scroll     - smooth animated scrolling
--    indent     - animated indent guides
--    notifier   - pretty notification pop-ups
--    zen        - distraction-free "study mode"            <Space>z
--    words      - highlight other uses of the word under the cursor
--    toggle     - handy on/off switches                    <Space>u...
-- ============================================================================

-- A few quotes for the dashboard footer; one is picked at random each launch.
local quotes = {
  "Sapere aude. (Dare to know. Horace)",
  "Nulla dies sine linea. (No day without a line. Pliny)",
  "Ars longa, vita brevis. (Skill takes long, life is short. Hippocrates)",
  "Per aspera ad astra. (Through hardships to the stars.)",
  "Festina lente. (Make haste slowly.)",
  "Scientia potentia est. (Knowledge is power. Bacon)",
  "Labor omnia vincit. (Work conquers all. Virgil)",
  "I know that I know nothing. (Socrates)",
  "Programs must be written for people to read. (Abelson & Sussman)",
  "Simplicity is prerequisite for reliability. (Dijkstra)",
  "Premature optimisation is the root of all evil. (Knuth)",
  "Clear is better than clever. (Go Proverb)",
}
math.randomseed(os.time())
local quote = quotes[math.random(#quotes)]

-- Helper: open a terminal. `count` gives each style (right/bottom/float) its
-- own separate terminal so they don't get mixed up.
local function term(position, count)
  return function()
    Snacks.terminal.toggle(nil, {
      count = count,
      win = { position = position, width = 0.4, height = 0.3 },
    })
  end
end

-- Helper: run a shell command (e.g. `go run .`) in a split on the right,
-- from the folder of the current file. You can type input while it runs
-- (for fmt.Scan etc.). When it finishes you're dropped back to normal mode
-- so you can scroll the output; press q to close it.
local last_run -- the previous run window, closed before starting a new one
local function run(cmd)
  return function()
    vim.cmd("silent! write") -- save first, so you run what you see
    if last_run and last_run:valid() then last_run:close() end
    last_run = Snacks.terminal.open(cmd, {
      cwd = vim.fn.expand("%:p:h"),
      auto_close = false, -- keep the output visible after the program exits
      win = { position = "right", width = 0.4 },
    })
    -- When the program exits, leave terminal mode (so keys don't close it).
    local buf = last_run.buf
    vim.api.nvim_create_autocmd("TermClose", {
      buffer = buf,
      once = true,
      callback = function()
        vim.schedule(function()
          if vim.api.nvim_get_current_buf() == buf and vim.api.nvim_get_mode().mode == "t" then
            vim.api.nvim_feedkeys(vim.keycode("<C-\\><C-n>"), "n", false)
          end
        end)
      end,
    })
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- file-type icons
  opts = {
    bigfile = { enabled = true },    -- turn off heavy features on huge files
    quickfile = { enabled = true },  -- show a file before plugins finish loading
    input = { enabled = true },      -- nicer text input boxes (e.g. rename)
    notifier = { enabled = true, timeout = 3000 },
    words = { enabled = true },
    statuscolumn = { enabled = true }, -- tidy gutter: signs, numbers, folds
    picker = { enabled = true, layout = { preset = "telescope" } },
    explorer = { enabled = true, replace_netrw = true }, -- `nvim .` opens the tree
    terminal = { enabled = true },

    -- ── Animations ────────────────────────────────────────────────────────
    scroll = { enabled = true,  -- smooth animated scrolling
      animate = { duration = { step = 15, total = 200 }, easing = "outQuad" },
    },
    indent = { enabled = true,  -- faint vertical lines showing indentation
      animate = { enabled = true, style = "out", duration = { step = 20, total = 300 } },
      scope = { enabled = true }, -- the block you're in is drawn stronger
    },

    -- ── Zen / study mode ──────────────────────────────────────────────────
    zen = {
      toggles = { dim = true, git_signs = false, diagnostics = true },
      win = { width = 100, backdrop = { transparent = false, blend = 90 } },
    },

    -- ── Dashboard: the start screen ───────────────────────────────────────
    dashboard = {
      enabled = true,
      preset = {
        header = [[
      __...--~~~~~-._   _.-~~~~~--...__      
    //               `V'               \\    
   //                 |                 \\   
  //__...--~~~~~~-._  |  _.-~~~~~~--...__\\  
 //__.....----~~~~._\ | /_.~~~~----.....__\\ 
====================\\|//====================
                    `---`                    
                                             
            S C R I P T O R I U M            
         sapere aude  ·  dare to know        ]],
        -- Each button: icon, key to press, label, what it does.
        keys = {
          { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New file", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Search text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "e", desc = "File explorer", action = ":lua Snacks.explorer()" },
          { icon = " ", key = "c", desc = "Edit config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = "󰒲 ", key = "L", desc = "Plugins", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 2 },
        { text = { { quote, hl = "SnacksDashboardFooter" } }, align = "center", padding = 1 },
        { section = "startup" }, -- "Neovim loaded N plugins in X ms"
      },
    },
  },

  -- ── Shortcuts ─────────────────────────────────────────────────────────────
  keys = {
    -- File explorer
    { "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },

    -- Finding things (fuzzy search: type any part of the name)
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Find files (smart)" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Find text in project (grep)" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Find word under cursor", mode = { "n", "x" } },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find open buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Find recent files" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Find errors/warnings" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Find help pages" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Find keymaps" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find config file" },
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Search in this file" },
    { "<leader>fn", function() Snacks.notifier.show_history() end, desc = "Notification history" },

    -- Terminals
    { "<leader>tv", term("right", 1), desc = "Terminal (vertical, right)" },
    { "<leader>th", term("bottom", 2), desc = "Terminal (horizontal, bottom)" },
    { "<leader>tf", term("float", 3), desc = "Terminal (floating)" },
    { "<C-/>", term("bottom", 2), desc = "Toggle terminal", mode = { "n", "t" } },
    { "<C-_>", term("bottom", 2), desc = "which_key_ignore", mode = { "n", "t" } }, -- same key in some terminals

    -- Run Go code (output in a split on the right)
    { "<leader>rr", run("go run ."), desc = "Run: go run . (this package)" },
    { "<leader>rf", function() run("go run " .. vim.fn.shellescape(vim.fn.expand("%:t")))() end, desc = "Run: this file only" },
    { "<leader>rt", run("go test ./..."), desc = "Run: go test ./..." },
    { "<leader>rv", run("go vet ./..."), desc = "Run: go vet ./..." },
    { "<leader>rb", run("go build ./..."), desc = "Run: go build ./..." },

    -- Git (read-only views; commit from a terminal with `git commit`)
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Open file on GitHub" },

    -- Buffers & focus
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Close buffer (keep window)" },
    { "<leader>z", function() Snacks.zen() end, desc = "Zen / study mode" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Pick a colourscheme" },
  },

  -- Extra on/off toggles, created once Neovim has started.
  -- They show up under <Space>u with their current state.
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark mode" }):map("<leader>ub")
        Snacks.toggle.option("relativenumber", { name = "Relative numbers" }):map("<leader>ur")
        Snacks.toggle.option("wrap", { name = "Line wrap" }):map("<leader>uw")
        Snacks.toggle.option("spell", { name = "Spell check" }):map("<leader>us")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
