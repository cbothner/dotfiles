vim.g.mapleader = ','
vim.api.nvim_set_keymap('n', '<leader>v', ':split ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
   local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
   if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
         { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
         { out,                            "WarningMsg" },
         { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
   end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   install = { colorscheme = { "Atelier_HeathDark" } },
   spec = {
      {
         "atelierbram/vim-colors_atelier-schemes",
         lazy = false,
         priority = 1000,
         config = function()
            vim.cmd([[colorscheme Atelier_HeathDark]])
            vim.opt.termguicolors = true
            vim.opt.background = 'dark'
         end,
      },

      -- Editing Mechanics
      --
      { 'tpope/vim-repeat' },                -- Fix repeating for plugin commands
      { 'tpope/vim-unimpaired' },            -- Pairwise commands [b
      { 'machakann/vim-sandwich' },          -- More vim-like vim-surround?
      { 'tpope/vim-dispatch' },              -- Run background processes in tmux tabs
      { 'tpope/vim-commentary' },            -- Toggle comments
      { 'vim-scripts/ReplaceWithRegister' }, -- Atomic replace text object
      { 'christoomey/vim-sort-motion' },     -- Sort a text object
      { 'Raimondi/delimitMate' },            -- Automatically insert matching brackets
      { 'tpope/vim-endwise' },               -- Automatically insert end
      { 'tommcdo/vim-lion' },                -- Align comments etc with gl#
      { 'tpope/vim-abolish' },               -- :%Subvert/facilit{y,ies}/building{,s}/g
      { 'tpope/vim-speeddating' },           -- <C-A> and <C-X> for dates
      { 'icatalina/vim-case-change' },       -- Makes ~ cycle through camel, snake case
      {
         'AndrewRadev/splitjoin.vim',        -- gS -- transform to multiline; gJ -- transform to oneliner
         config = function()
            vim.g.splitjoin_trailing_comma = 1
            vim.g.splitjoin_ruby_hanging_args = 0
            vim.g.splitjoin_ruby_curly_braces = 0
            vim.g.splitjoin_ruby_options_as_arguments = 1
         end
      },

      -- Text Objects
      --
      {
         'fvictorio/vim-textobj-backticks', -- i`
         dependencies = { 'kana/vim-textobj-user' }
      },
      {
         'kana/vim-textobj-entire', -- ie -- entire document
         dependencies = { 'kana/vim-textobj-user' }
      },
      {
         'kana/vim-textobj-indent', -- ii -- area of common indent
         dependencies = { 'kana/vim-textobj-user' }
      },
      {
         'kana/vim-textobj-line', -- il
         dependencies = { 'kana/vim-textobj-user' }
      },
      {
         'machakann/vim-textobj-delimited', -- id -- each delimited part of a camel/snake/kabob-case word
         dependencies = { 'kana/vim-textobj-user' }
      },
      {
         'reedes/vim-textobj-quote', -- iq -- curly quotes.
         dependencies = { 'kana/vim-textobj-user' }
      },
      {
         'tek/vim-textobj-ruby', -- if(unction), c(lass), and r for a block. an for a Scoped::Name
         dependencies = { 'kana/vim-textobj-user' }
      },
      {
         'whatyouhide/vim-textobj-xmlattr', -- ix
         dependencies = { 'kana/vim-textobj-user' }
      },

      -- UI Enhancements
      --
      { 'lewis6991/gitsigns.nvim', opts = {} }, -- Diff markers in the gutter
      {
         'bling/vim-airline',
         dependencies = {
            { 'vim-airline/vim-airline-themes' },
         },
         config = function()
            vim.g.airline_theme = 'lucius' -- 'lucius' is a good general-purpose theme

            vim.g.airline_powerline_fonts = 1
            vim.g['airline#extensions#tabline#enabled'] = 1
            vim.g['airline#extensions#branch#enabled'] = 1
         end
      },

      -- IDE-Like Behavior
      --
      { 'tpope/vim-fugitive' }, -- Git
      { 'tpope/vim-rhubarb' },  -- GitHub
      {
         'rizzatti/dash.vim',   -- Open the docs
         config = function()
            vim.api.nvim_set_keymap('n', 'K', ':Dash<CR>', { noremap = true, silent = true })
         end
      },
      { 'tpope/vim-projectionist' }, -- :Econtroller user
      {
         'junegunn/fzf.vim',
         dependencies = {
            {
               'junegunn/fzf',
               build = function() vim.fn.system { './install', '--all' } end,
               dir = '~/.fzf'
            },
         },
         config = function()
            vim.env.BAT_THEME = 'base16-atelierheath.light'
            vim.g.fzf_colors = {
               fg = { 'fg', 'Normal' },
               bg = { 'bg', 'Normal' },
               hl = { 'fg', 'Comment' },
               ["fg+"] = { 'fg', 'SignColumn', 'CursorColumn', 'Normal' },
               ["bg+"] = { 'bg', 'SignColumn', 'CursorColumn' },
               ["hl+"] = { 'fg', 'Statement' },
               info = { 'fg', 'PreProc' },
               border = { 'fg', 'Ignore' },
               prompt = { 'fg', 'Conditional' },
               pointer = { 'fg', 'Exception' },
               marker = { 'fg', 'Keyword' },
               spinner = { 'fg', 'Label' },
               header = { 'fg', 'Comment' }
            }

            vim.api.nvim_set_keymap('n', '<c-p>', ':Files<CR>', { silent = true })
            vim.api.nvim_set_keymap('n', '<c-t>', ':Buffers<CR>', { silent = true })
            vim.api.nvim_set_keymap('n', '<c-f>', ':Rg<CR>', { silent = true })

            -- An action can be a reference to a function that processes selected lines
            local function build_quickfix_list(lines)
               vim.fn.setqflist(vim.fn.map(vim.fn.copy(lines), '{ "filename": v:val }'))
               vim.cmd('copen')
               vim.cmd('cc')
            end

            vim.g.fzf_action = {
               ['ctrl-q'] = build_quickfix_list,
               ['ctrl-t'] = 'tab split',
               ['ctrl-x'] = 'split',
               ['ctrl-v'] = 'vsplit'
            }
         end
      },

      {
         'neovim/nvim-lspconfig',
         dependencies = {
            {
               "folke/lazydev.nvim",
               ft = "lua", -- only load on lua files
               opts = {
                  library = {
                     { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                  },
               },
            },
         },
         config = function()
            local lspconfig = require 'lspconfig'

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
               client.request = require('lspfuzzy').wrap_request(client.request)

               local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
               local function buf_set_option(name, value) vim.api.nvim_set_option_value(name, value, { buf = bufnr }) end

               --Enable completion triggered by <c-x><c-o>
               buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

               -- Mappings.
               local opts = { noremap = true, silent = true }

               -- See `:help vim.lsp.*` for documentation on any of the below functions
               buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
               buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
               buf_set_keymap('n', '<leader><leader>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
               buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
               buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
               buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
               buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
               buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
               buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
               buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
               buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
            end

            -- vim.lsp.set_log_level("info")
            lspconfig.sorbet.setup({ on_attach = on_attach })
            lspconfig.ruby_lsp.setup({
               on_attach = on_attach,
               init_options = {
                  enabledFeatures = {
                     semanticHighlighting = false
                  },
                  tapiocaAddon = true,
               },
            })
            lspconfig.rust_analyzer.setup({
               on_attach = on_attach,
               settings = {
                  ['rust-analyzer'] = {
                     cargo = {
                        buildScripts = {
                           enable = true,
                        },
                        loadOutDirsFromCheck = true,
                        procMacro = {
                           enable = true,
                        },
                     },
                  }
               }
            })
            lspconfig.ts_ls.setup({ on_attach = on_attach })
            lspconfig.clangd.setup({
               on_attach = on_attach,
               cmd = { 'clangd', '--header-insertion=never', '--query-driver=**' },
            })
            lspconfig.zls.setup({
               on_attach = on_attach,
               cmd = { 'zls' },
               settings = {
                  zls = {
                     enable_build_on_save = true,
                  }
               }
            })
            lspconfig.lua_ls.setup { on_attach = on_attach }
         end
      },

      {
         'ojroques/nvim-lspfuzzy',
         opts = {},
         dependencies = {
            { 'junegunn/fzf.vim' },
         },
      },

      {
         'hrsh7th/nvim-cmp',
         dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/vim-vsnip' },
         },
         config = function()
            local cmp = require "cmp"
            cmp.setup({
               snippet = {
                  expand = function(args)
                     vim.fn["vsnip#anonymous"](args.body)
                  end,
               },
               mapping = cmp.mapping.preset.insert({
                  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                  ['<C-f>'] = cmp.mapping.scroll_docs(4),
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.abort(),
                  ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
                  ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
                  ['<CR>'] = cmp.mapping.confirm({ select = false }),
               }),
               sources = cmp.config.sources({ { name = 'nvim_lsp' } }, { { name = 'buffer' } })
            })
            cmp.setup.cmdline(':', {
               mapping = cmp.mapping.preset.cmdline(),
               sources = cmp.config.sources({
                  { name = 'path' }
               }, {
                  { name = 'cmdline' }
               }),
            })
         end
      },

      {
         'stevearc/conform.nvim',
         opts = {
            formatters_by_ft = {
               graphql = { "prettier" },
               javascript = { "prettier" },
               json = { "prettier" },
               lua = { "stylua" },
               sql = { "sqlfmt" },
               typescript = { "prettier" },
               yaml = { "prettier" },
            },
         },
         config = function(_, opts)
            require("conform").setup(opts)
            vim.api.nvim_set_keymap('n', '<leader>f',
               [[:lua require("conform").format({ async = true, lsp_format = "fallback", range = range })<CR>]],
               { silent = true })
         end
      },

      { 'ntpeters/vim-better-whitespace' }, -- Highlight trailing whitespace
      { 'vim-scripts/Rename' },
      { 'christoomey/vim-tmux-navigator' },
      { 'Shopify/shadowenv.vim',         enabled = vim.fn.executable('shadowenv') == 1 },
      {
         'janko/vim-test',
         config = function()
            vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', { silent = true })
            vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', { silent = true })
            vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<CR>', { silent = true })
            vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', { silent = true })
            vim.api.nvim_set_keymap('n', '<leader>tg', ':TestVisit<CR>', { silent = true })
            vim.g['test#strategy'] = "dispatch"
            vim.g.dispatch_tmux_pipe_pane = 1 -- needed so $stdout.tty? is true and reline works when debugging
         end
      },

      {
         'kevinhwang91/nvim-ufo',
         dependencies = {
            { 'kevinhwang91/promise-async' },
         },
         init = function()
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
         end,
         opts = {}
      },

      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      {
         'kristijanhusak/vim-dadbod-ui',
         dependencies = {
            { 'tpope/vim-dadbod' },
         },
      },

      {
         'stevearc/oil.nvim',
         ---@module 'oil'
         ---@type oil.SetupOpts
         opts = {
            keymaps = {
               ["<C-p>"] = false
            },
         },
         dependencies = { { "echasnovski/mini.icons", opts = {} } },
         lazy = false,
      },

      -- AI
      --
      { 'github/copilot.vim' },

      -- Language Support
      --

      -- Assembly
      { 'nviennot/vim-armasm' },

      -- Crystal
      { 'rhysd/vim-crystal' },

      -- CSS
      { 'hail2u/vim-css3-syntax' },
      -- { 'gko/vim-coloresque' }, -- Highlight colors like #009bf9

      -- Elixir
      { 'elixir-editors/vim-elixir' },

      -- Go
      { 'jnwhiteh/vim-golang' },

      -- HTML
      { 'alvan/vim-closetag' },

      -- Javascript etc.
      { 'othree/yajs.vim' },
      { 'othree/es.next.syntax.vim' },
      { 'mxw/vim-jsx' },
      { 'Quramy/vim-js-pretty-template' },
      { 'HerringtonDarkholme/yats.vim' },
      { 'posva/vim-vue' },
      { 'kchmck/vim-coffee-script' },
      { 'jparise/vim-graphql' },

      -- Markdown
      { 'plasticboy/vim-markdown' },

      -- Liquid
      { 'tpope/vim-liquid' },

      -- Reason
      { 'reasonml-editor/vim-reason-plus' },

      -- Ruby
      { 'vim-ruby/vim-ruby' },
      { 'tpope/vim-rails' },
      { 'tpope/vim-bundler' },
      { 'thoughtbot/vim-rspec' },
      { 'noprompt/vim-yardoc' },

      -- TOML
      { 'cespare/vim-toml' },

      -- YAML
      { 'stephpy/vim-yaml' },
      { 'pedrohdz/vim-yaml-folds' },

      -- Zig
      { 'ziglang/zig.vim' },
   },
})

-- Editing Mechanics
vim.opt.backspace = 'indent,eol,start' -- Let backspace wrap
vim.opt.whichwrap:append('<,>,h,l')    -- Let movement wrap
vim.opt.expandtab = true               -- Use spaces instead of tabs
vim.opt.smarttab = true                -- Be smart when using tabs
vim.opt.shiftwidth = 2                 -- Tab width
vim.opt.tabstop = 2                    -- "
vim.opt.autoindent = true              -- Auto indent
vim.opt.smartindent = true             -- Smart indent
vim.opt.wrap = true                    -- Wrap lines
vim.opt.textwidth = 80                 -- Limit line length
vim.opt.linebreak = true               -- Soft wrap at word boundaries

-- Smashing escape mapping
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true })

-- Indenting that keeps visuals selected
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

-- Fast save
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<CR>', { noremap = true })

-- Treat long lines as break lines (useful when moving around in them)
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- Don’t open folds when using { and } to move
vim.opt.foldopen:remove('block')

vim.g.delimitMate_expand_cr = 1
vim.g.delimitMate_expand_space = 1

-- UI enhancements
vim.cmd('syntax enable')

vim.opt.number = true         -- Show line number
vim.opt.relativenumber = true -- Use relative line numbers
vim.opt.scrolloff = 7         -- Pad the edge of the screen
vim.opt.cmdheight = 2         -- Height of the command bar
vim.opt.hidden = true         -- A buffer becomes hidden when it is abandoned
vim.opt.showmatch = true      -- Show matching brackets when text indicator is over them
vim.opt.matchtime = 2         -- How many tenths of a second to blink when matching brackets
vim.opt.laststatus = 2        -- Always show statusline
vim.opt.colorcolumn = '121'   -- Show where 120 chars is
vim.opt.list = true           -- Show the below hidden characters
vim.opt.listchars = { tab = '>-', trail = '·' }

-- GUI Options
if vim.fn.has("gui_running") == 1 then
   vim.opt.guifont = "IBM Plex Mono"
   vim.opt.guioptions:remove('L')
   vim.opt.guioptions:remove('r')
   vim.opt.showtabline = 0
   vim.g.solarized_menu = 0
   vim.g.airline_powerline_fonts = 0
end

if vim.fn.has('mouse_sgr') == 1 then
   vim.opt.ttymouse = 'sgr'
end


vim.api.nvim_set_keymap('n', '[t', ':tabprevious<CR>', { silent = true })
vim.api.nvim_set_keymap('n', ']t', ':tabnext<CR>', { silent = true })

-- IDE-like behavior
vim.opt.ignorecase = true           -- Ignore case when searching
vim.opt.hlsearch = true             -- Highlight search results
vim.opt.incsearch = true            -- Search as I type
vim.opt.smartcase = true            -- When searching try to be smart about cases
vim.opt.wildmenu = true             -- Turn on the WiLd menu
vim.opt.wildignore = '*.o,*~,*.pyc' -- Ignore compiled files
vim.opt.undofile = true             -- Persistent history between sessions

-- Toggle spell check
vim.api.nvim_set_keymap('n', '<leader>s', ':set spell!<CR>', { noremap = true, silent = true })
vim.opt.spelllang = 'en'

-- cd to this file’s directory
vim.api.nvim_set_keymap('n', '<leader>lcd', ':cd %:p:h<CR>', { noremap = true, silent = true })

-- Clean up when <leader><cr> is pressed
-- vim.api.nvim_set_keymap('n', '<leader><CR>', ':noh<CR>:ccl<CR>:GitGutterAll<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><CR>', ':noh<CR>:ccl<CR>', { noremap = true, silent = true })

vim.opt.mouse = 'a' -- Mouses are useful

-- Smart way to move between windows
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true })

-- Close the current buffer
vim.api.nvim_set_keymap('n', '<leader>bd', ':Kwbd<CR>', { noremap = true })
-- Close all the buffers
vim.api.nvim_set_keymap('n', '<leader>ba', ':1,1000 bd!<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>e', ':Oil<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>E', ':e!<CR>', { noremap = true, silent = true })

-- Specify the behavior when switching between buffers
vim.opt.switchbuf = 'useopen,usetab,newtab'
vim.opt.stal = 2

-- Return to last edit position when opening files
vim.cmd([[
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif
]])

-- Search for current selection
vim.api.nvim_set_keymap('v', '*', 'y/\\V<C-r>=escape(@",\'/\\\')<CR><CR>', { noremap = true })

-- Language support

-- Assembly
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
   pattern = "*.asm",
   command = "let asmsyntax='armasm'|let filetype_inc='armasm'"
})

-- HAML
vim.api.nvim_create_autocmd("FileType", {
   pattern = "haml",
   command = "setlocal iskeyword-=."
})

-- HTML
vim.g.closetag_filetypes = 'eruby,html,xhtml'
vim.api.nvim_create_autocmd("FileType", {
   pattern = "eruby,html,xhtml",
   command = "let b:delimitMate_matchpairs = '(:),[:],{:}'"
})

-- Javascript etc.
vim.g.jsx_ext_required = 0
vim.api.nvim_create_autocmd("FileType", {
   pattern = "javascript",
   command = "set foldmethod=syntax"
})
vim.api.nvim_create_autocmd("FileType", {
   pattern = "javascript",
   command = "let b:delimitMate_quotes = '\"'`'"
})
vim.g.vue_disable_pre_processors = 1

-- LaTeX
vim.api.nvim_create_autocmd("FileType", {
   pattern = "tex",
   command = "nnoremap <leader>ll :!lualatex %<cr>"
})
vim.api.nvim_create_autocmd("FileType", {
   pattern = "tex",
   command = "nnoremap <leader>lb :!lualatex %:r; biber %:r; lualatex %:r;<cr>"
})
vim.api.nvim_create_autocmd("FileType", {
   pattern = "tex",
   command = "nnoremap <leader>lv :!open %:r.pdf<cr>"
})

-- Lua
vim.api.nvim_create_autocmd("FileType", {
   pattern = "lua",
   command = "set autoindent expandtab tabstop=3 shiftwidth=3"
})

-- Markdown
vim.g.vim_markdown_toc_autofit = 1
vim.g.vim_markdown_folding_level = 6
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_fenced_languages = {
   'js=typescript',
   'jsx=typescript',
   'ts=typescript',
   'haskell=haskell',
   'tsx=typescript'
}
vim.g.vim_markdown_new_list_item_indent = 0
vim.api.nvim_create_autocmd("FileType", {
   pattern = "markdown",
   command = "setlocal formatoptions=twacq spell"
})
vim.api.nvim_create_autocmd("FileType", {
   pattern = "markdown",
   command = "call textobj#quote#init()"
})
vim.api.nvim_create_autocmd("FileType", {
   pattern = "markdown",
   command = "let b:delimitMate_expand_space = 0"
})

-- Mail
vim.api.nvim_create_autocmd("FileType", {
   pattern = "mail",
   command = "setlocal textwidth=80 formatoptions=twacq spell nolist bg=light"
})

-- Ruby
vim.api.nvim_create_autocmd("FileType", {
   pattern = "ruby",
   command = "setlocal iskeyword-=."
})
vim.g.rails_projections = {
   ["config/routes.rb"] = {
      command = "routes"
   },
   ["spec/features/*_spec.rb"] = {
      type = "feature",
      template = {
         "require 'rails_helper'",
         "",
         "feature '{underscore|capitalize|blank}' do",
         "",
         "end"
      }
   }
}
vim.g.rails_gem_projections = {
   ["factory_bot_rails"] = {
      ["spec/factories/*.rb"] = {
         type = "factory",
         template = {
            "FactoryBot.define do",
            "  factory :{underscore} do",
            "",
            "  end",
            "end"
         },
         related = "app/models/{}.rb"
      }
   }
}

-- Fade out sorbet signatures
vim.api.nvim_create_augroup("format_ruby", { clear = true })
vim.api.nvim_create_autocmd("Syntax", {
   pattern = "ruby",
   command = "syntax region sorbetSig start='sig {' end='}'",
   group = "format_ruby"
})
vim.api.nvim_create_autocmd("Syntax", {
   pattern = "ruby",
   command = "syntax region sorbetSig start='sig do' end='end'",
   group = "format_ruby"
})
vim.api.nvim_create_autocmd("Syntax", {
   pattern = "ruby",
   command = "highlight link sorbetSig Comment",
   group = "format_ruby"
})

-- Rust
vim.api.nvim_create_autocmd("FileType", {
   pattern = "rust",
   command = "setlocal colorcolumn=100"
})

-- Zig
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

-- Technical details

vim.opt.encoding = 'utf8'
vim.opt.ffs = 'unix,dos,mac' -- Use Unix as the standard file type
vim.opt.lazyredraw = true    -- Don't redraw while executing macros (perf)
vim.opt.magic = true         -- For regular expressions turn magic on
vim.opt.errorbells = false   -- No annoying sound on errors
vim.opt.tm = 500             -- Timeout
vim.opt.history = 700        -- Long memory
vim.opt.hidden = true        -- CoC wants this set?
vim.opt.updatetime = 300     -- So CursorHold fires after a more reasonable time
