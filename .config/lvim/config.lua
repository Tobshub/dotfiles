-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "no-clown-fiesta"


vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.titlestring = "NVIM %F"
vim.opt.sidescrolloff = 2
vim.opt.scrolloff = 2
vim.opt.clipboard = ""
vim.opt.background = "dark"
vim.opt.shell = "/usr/bin/zsh"
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars:append("extends:<")
vim.opt.listchars:append("precedes:>")
-- vim.opt.listchars:append("tab:» ")
-- vim.opt.listchars:append("tab:• ")
vim.opt.listchars:append("tab:  ")

lvim.builtin.indentlines.active = true
lvim.builtin.indentlines.options.char = ""
lvim.builtin.indentlines.options.context_char = "•"

lvim.builtin.illuminate.active = false

vim.diagnostic.config({ virtual_text = false, float = { border = "single" } })

lvim.builtin.cmp.formatting.max_width = 40
lvim.builtin.cmp.performance = { debounce = 10, throttle = 5 }
lvim.builtin.cmp.window.completion.border = "single"
-- lvim.builtin.cmp.window.completion.winhighlight = "Normal:Pmenu"
lvim.builtin.cmp.window.documentation.border = "single"
-- lvim.builtin.cmp.window.documentation.winhighlight = "Normal:Pmenu"

lvim.builtin.luasnip.sources.friendly_snippets = false
lvim.builtin.cmp.cmdline.enable = true

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "single" }
)

lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.persist_size = true
lvim.builtin.terminal.size = 12

-- lvim.builtin.autopairs.enable_moveright = false
-- lvim.builtin.autopairs.active = false

lvim.builtin.breadcrumbs.active = true
vim.list_extend(lvim.builtin.breadcrumbs.winbar_filetype_exclude, { "astro" })
vim.g.navic_silence = true

require('lspconfig.ui.windows').default_options.border = "single"

lvim.builtin.lir.show_hidden_files = true
lvim.builtin.lir.ignore = {}

lvim.builtin.telescope.defaults.layout_strategy = "flex"
lvim.builtin.telescope.defaults.layout_config.horizontal = { width = 0.8, height = 0.8, }
lvim.builtin.telescope.defaults.layout_config.vertical = { width = 0.8, height = 0.8 }
lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"
lvim.builtin.telescope.theme = nil
-- lvim.builtin.telescope.defaults.borderchars = {
-- 	prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
-- 	results = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
-- 	preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
-- }

lvim.builtin.telescope.defaults.path_display = {}
lvim.builtin.telescope.pickers.live_grep.only_sort_text = false

-- lvim.builtin.telescope.on_config_done = function(telescope)
-- 	pcall(telescope.load_extension, "fzy-native")
-- end

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- codeium
vim.g.codeium_no_map_tab = true

-- local mndap = require("mason-nvim-dap")
-- mndap.setup({
--   handlers = {
--     function(config)
--       mndap.default_setup(config)
--     end
--   }
-- })

-- local mlspconf = require("mason-lspconfig")
-- mlspconf.setup_handlers({
--   function(server_name)
--     require("lvim.lsp.manager").setup(server_name, {})
--   end,
--   ["rust_analyzer"] = function()
--     require("lvim.lsp.manager").setup("rust_analyzer", {
--       settings = {
--         ["rust-analyzer"] = {
--           check = {
--             command = "clippy",
--           },
--         }
--       }
--     })
--   end
-- })

-- lvim.builtin.lualine.options.theme = "auto"
local lualinecmpnts = require("lvim.core.lualine.components")
lvim.builtin.lualine.style = "lvim"
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_c = {
  lualinecmpnts.diff, { "filename", path = 3 }
}
lvim.builtin.lualine.sections.lualine_x = { lualinecmpnts.diagnostics }

lvim.transparent_window = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

vim.keymap.set({ "i", "t" }, "<C-l>", "<Del>")
vim.keymap.set("t", "<C-h>", "<BackSpace>")
vim.keymap.set("v", "<S-y>", "\"+y", { noremap = true })
vim.keymap.set("n", "<C-;>", "q:")

lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 2000 }
  end,
  "Format",
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Terminal",
  t = {
    ":term<cr>",
    "Open new terminal tab"
  },
  r = {
    ":.w !zsh<cr>",
    "Run current line"
  }
}

vim.keymap.set("t", "<C-Esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("n", "<C-cr>", function()
  local win = vim.api.nvim_get_current_win()
  local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
  if (name == nil or name == "") then
    local key = vim.api.nvim_replace_termcodes("<cr>", true, false, true)
    vim.api.nvim_feedkeys(key, "n", false)
    vim.api.nvim_create_autocmd("BufLeave", {
      once = true,
      callback = function()
        vim.api.nvim_win_close(win, true)
      end,
    })
  end
end, { noremap = true })

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shell = "/usr/bin/zsh"
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.renderer.indent_markers.enable = true
-- lvim.builtin.nvimtree.setup.view.float.enable = true
lvim.builtin.nvimtree.setup.update_cwd = false
lvim.builtin.nvimtree.setup.actions.change_dir.enable = false
lvim.builtin.nvimtree.setup.sync_root_with_cwd = false
lvim.builtin.nvimtree.setup.respect_buf_cwd = false
lvim.builtin.nvimtree.setup.prefer_startup_root = true
lvim.builtin.nvimtree.setup.update_focused_file.update_root.enable = false
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false
lvim.builtin.project.manual_mode = true

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
  "yaml",
  "html",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

require('treesitter-context').setup({
  -- enable = true,
  max_lines = 4,
  -- min_window_height = 0,
  -- line_numbers = true,
  -- multiline_threshold = 20,
  trim_scope = 'outer',
  -- mode = 'cursor',
  separator = '─',
  -- zindex = 20
})


-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)
--

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "eslintls"
end, lvim.lsp.automatic_configuration.skipped_servers)

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
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  {
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    { "--print-width", "120" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "astro", "typescript", "typescriptreact", "javascript", "javascriptreact", "css", "scss", "sass",
      "yaml", "json", "mdx", "md", "vue" },
  },
  { command = "gofumpt", { "-lw" }, filetypes = { "go" } },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  {
    "windwp/nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup() end
  },
  -- { "RRethy/nvim-base16" },
  -- { "tjdevries/colorbuddy.nvim" },
  -- { "tobshub/tsodingbuddy",       dependencies = "tjdevries/colorbuddy.nvim" },
  -- { "norcalli/nvim-colorizer.lua" },
  {
    "Exafunction/codeium.vim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      vim.keymap.set("i", '<C-S-Space>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    end
  },
  { "jay-babu/mason-nvim-dap.nvim",           dependencies = "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim",      dependencies = "williamboman/mason.nvim" },
  -- { "tobshub/vim-monokai-tasty" },
  -- { "Mofiqul/vscode.nvim" },
  { "nvim-treesitter/nvim-treesitter-context" },
  -- { "marko-cerovac/material.nvim" },
  -- { "rose-pine/neovim",                       name = "rose-pine" },
  -- {
  -- 	"nvim-telescope/telescope-fzy-native.nvim",
  -- 	build = "make",
  -- 	event = "BufRead"
  -- },
  { "aktersnurra/no-clown-fiesta.nvim" },
  { "wakatime/vim-wakatime",                  lazy = false },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc", ".env", "*.md", "*txt" },
  command = "setlocal wrap",
})

-- set tabstop and shiftwidth to 4
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.go", "*.c", "*.h", "*.cpp", "*.hpp", "*.cc", "*.cxx", "*.rs" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end
})


-- turn off nvim-navic in astro files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.astro" },
  callback = function()
    lvim.builtin.breadcrumbs.active = false
    vim.g.navic_silence = true
  end
})
