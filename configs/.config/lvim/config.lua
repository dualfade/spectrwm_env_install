--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- refs --
-- https://github.com/abzcoding/lvim

-- general
lvim.log.level = "warn"
lvim.format_on_save = true

-- default --
-- lvim.colorscheme = "lunar"

-- set custom theme
-- https://github.com/folke/tokyonight.nvim
-- lvim.colorscheme = "tokyonight"
-- lvim.builtin.lualine.options.theme = "tokyonight"

-- https://github.com/catppuccin/nvim --
lvim.colorscheme = "catppuccin-macchiato"
lvim.builtin.lualine.options.theme = "catppuccin"

-- lvim.colorscheme = "onenord"
-- lvim.builtin.lualine.options.theme = "onenord"

-- https://github.com/EdenEast/nightfox.nvim
-- lvim.colorscheme = "nightfox"
-- lvim.colorscheme = "duskfox"
-- lvim.colorscheme = "nordfox"
-- lvim.colorscheme = "terafox"
-- lvim.colorscheme = "carbonfox"

-- require('nightfox').setup({
--   options = {
--     styles = {
--       comments = "italic",
--       keywords = "bold",
--       types = "italic,bold",
--     }
--   }
-- })

-- https://www.lunarvim.org/docs/configuration/statusline
lvim.builtin.lualine.style = "lvim"
lvim.builtin.lualine.sections.lualine_c = { "diff" }

-- enable mouse --
vim.opt.mouse = "a"

-- disable mouse --
-- vim.opt.mouse = ''

-- disable top tab(s) line
-- https://vimhelp.org/options.txt.html
vim.opt.showtabline = 0

-- disable cursor wrapping; whichwrap --
-- vim.opt.ww = ''

-- https://bit.ly/3Pm9Qdy --
-- tab stop --
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "99999"
vim.opt.wrap = false
vim.opt.updatetime = 300

-- https://bit.ly/3iGV41W --
-- vim.cmd("map 0 ^")
-- vim.cmd("nnoremap Q <nop>")
-- vim.cmd("nnoremap j gj")
-- vim.cmd("nnoremap k gk")

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "go",
  "ruby",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- needed for matchup
-- this should be a default with lunavrim settings
-- https://github.com/andymass/vim-matchup/issues/262
lvim.builtin.treesitter.matchup.enable = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. dependencies `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- updated options --
-- lvim.lsp.automatic_configuration.skipped_servers = { "pyright" }

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- NOTE: ruby solargraph fix --
-- https://github.com/LunarVim/LunarVim/issues/945 --
require("lspconfig").solargraph.setup({
  cmd = { "/home/dualfade/.local/share/gem/ruby/3.0.0/bin/solargraph", "stdio" },
  -- cmd = { "/home/dualfade/.local/share/gem/ruby/3.0.0/bin/solargraph", "socket", "7658" },
  -- system solargraph --
  -- cmd = { "/usr/bin/solargraph", "stdio" },
})

-- NOTE: enable sorbet-runtime
-- https://sorbet.org/
-- swiped and mod from; https://lsp.sublimetext.io/language_servers/#sorbet
-- require("lspconfig").sorbet.setup {
--   cmd = {
--     "srb", "tc", "--typed", "true", "--enable-all-experimental-lsp-features", "--lsp", "--disable-watchman"
--   },
-- }

-- NOTE: 22:27 briain@d
-- fix telescope window sizing --
-- ref: https://github.com/nvim-telescope/telescope.nvim --
lvim.builtin.telescope.pickers = {
  find_files = {
    layout_config = {
      vertical = { width = 0.5 },
    },
  },
  live_grep = {
    layout_config = {
      width = 0.5,
    },
  },
}

-- https://github.com/LunarVim/LunarVim/issues/1747
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  {
    command = "prettier",
    extra_args = { "--print-with", "100" },
    filetypes = {
      "python",
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "json",
      "markdown",
    },
  },
})

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  {
    command = "eslint_d",
    filetypes = { "typescript", "typescriptreact" },
  },
})
linters.setup({
  -- { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python", "ruby", "eruby", "go" },
  },
})

-- Additional Plugins
lvim.plugins = {
  -- https://github.com/EdenEast/nightfox.nvim
  { "EdenEast/nightfox.nvim" },
  -- tiagovla/tokyodark.nvim
  -- { 'tiagovla/tokyodark.nvim' },
  -- https://github.com/rmehri01/onenord.nvim
  { "rmehri01/onenord.nvim" },
  { "catppuccin/nvim" },
  -- https://github.com/andymass/vim-matchup
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  { "folke/trouble.nvim",      cmd = "TroubleToggle" },
  { "thaerkh/vim-indentguides" },
  { "cappyzawa/trim.nvim" },
  -- https://github.com/wfxr/minimap.vim
  -- {
  --   "wfxr/minimap.vim",
  --   build = "cargo install --locked code-minimap",
  --   cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
  --   config = function()
  --     vim.cmd("let g:minimap_width = 20")
  --     vim.cmd("let g:minimap_auto_start = 1")
  --     vim.cmd("let g:minimap_auto_start_win_enter = 1")
  --   end,
  -- },

  -- https://github.com/folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  -- https://prettier.io/
  -- yain prettier
  -- :Prettier
  { "prettier/vim-prettier" },
  -- https://github.com/sindrets/diffview.nvim
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  -- https://github.com/rafamadriz/friendly-snippets --
  -- https://github.com/rafamadriz/friendly-snippets/wiki/Python --
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  -- https://github.com/rafamadriz/friendly-snippets --
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  -- https://github.com/CRAG666/code_runner.nvim
  { "CRAG666/code_runner.nvim", dependencies = "nvim-lua/plenary.nvim" },

  --NOTE: check this tomorrow  / 022520231 --
  -- https://github.com/mfussenegger/nvim-dap --
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation --
  -- { 'mfussenegger/nvim-dap' },
  -- { "rcarriga/nvim-dap-ui",     dependencies = { "mfussenegger/nvim-dap" } },

  -- https://github.com/MunifTanjim/nui.nvim --
  -- https://github.com/rcarriga/nvim-notify --
  -- https://github.com/folke/noice.nvim --
  { "MunifTanjim/nui.nvim" },
  { "rcarriga/nvim-notify" },
  { "folke/noice.nvim" },
}
-- end func

-- friendly-snippets extra requires --
-- https://github.com/rafamadriz/friendly-snippets/wiki --
require("luasnip").filetype_extend("typescript", { "javascript" })
require 'luasnip'.filetype_extend("ruby", { "rails" })

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})

--NOTE: this may not be working right now --
-- https://github.com/rcarriga/nvim-dap-ui --
-- require("neodev").setup({
--   library = { plugins = { "nvim-dap-ui" }, types = true },
-- })
-- require("dapui").setup()

-- Dap debugger --
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript --
-- local dap = require('dap')
-- dap.adapters.node2 = {
--   type = 'executable',
--   command = 'node',
--   args = { os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
-- }
-- dap.configurations.javascript = {
--   {
--     name = 'Launch',
--     type = 'node2',
--     request = 'launch',
--     program = '${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal',
--   },
--   {
--     -- For this to work you need to make sure the node process is started with the `--inspect` flag.
--     name = 'Attach to process',
--     type = 'node2',
--     request = 'attach',
--     processId = require 'dap.utils'.pick_process,
--   },
-- }

-- https://github.com/folke/trouble.nvim
lvim.builtin.which_key.mappings["t"] =
    {
      name = "Diagnostics",
      t = { "<cmd>TroubleToggle<cr>", "trouble" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
      l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
      r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
    },
    -- call trim after plugin load --
    -- https://github.com/cappyzawa/trim.nvim
    require("trim").setup({
      -- if you want to ignore markdown file.
      -- you can specify filetypes.
      -- disable = { "markdown" },
      ft_blocklist = { "markdown" },
      -- if you want to ignore space of top
      patterns = {
        [[%s/\s\+$//e]],
        [[%s/\($\n\s*\)\+\%$//]],
        [[%s/\(\n\n\)\n\+/\1/]],
      },
    })

-- call code_runner after plugin loads --
require("code_runner").setup({
  -- put here the commands by filetype
  filetype = {
    -- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    -- disable def; can hang and make biffer go crazy --
    -- python = "python3 -u",
    python = "cd $dir && python $fileName",
    typescript = "deno run",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
    ruby = "cd $dir && ruby $fileName",
    go = "cd $dir && go run $fileName",
    -- launch node w/wo debugger; custom --
    javascript = "cd $dir && node $fileName",
    -- javascript = "cd $dir && node inspect $fileName"
    -- javascript = "cd $dir && /usr/bin/node --inspect /home/dualfade/Scripts/Src/Node/contact/node_modules/forever/bin/forever $fileName"
  },
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
