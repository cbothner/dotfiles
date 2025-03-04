vim.g.mapleader = ','
vim.api.nvim_set_keymap('n', '<leader>v', ':split ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

local Plug = vim.fn['plug#']
vim.fn['plug#begin']()

-- Editing Mechanics
Plug('tpope/vim-repeat')                -- Fix repeating for plugin commands
Plug('tpope/vim-unimpaired')            -- Pairwise commands [b
Plug('machakann/vim-sandwich')          -- More vim-like vim-surround?
Plug('tpope/vim-dispatch')              -- Run background processes in tmux tabs
Plug('tpope/vim-commentary')            -- Toggle comments
Plug('vim-scripts/ReplaceWithRegister') -- Atomic replace text object
Plug('christoomey/vim-sort-motion')     -- Sort a text object
Plug('Raimondi/delimitMate')            -- Automatically insert matching brackets
Plug('tpope/vim-endwise')               -- Automatically insert end
Plug('tommcdo/vim-lion')                -- Align comments etc with gl#
Plug('tpope/vim-abolish')               -- :%Subvert/facilit{y,ies}/building{,s}/g
Plug('tpope/vim-speeddating')           -- <C-A> and <C-X> for dates
Plug('icatalina/vim-case-change')       -- Makes ~ cycle through camel, snake case
Plug('AndrewRadev/splitjoin.vim')       -- gS -- transform to multiline; gJ -- transform to oneliner

-- Text Objects
Plug('kana/vim-textobj-user')
Plug('fvictorio/vim-textobj-backticks') -- i`
Plug('kana/vim-textobj-diff')           -- idh -- diff section
Plug('kana/vim-textobj-entire')         -- ie -- entire document
Plug('kana/vim-textobj-indent')         -- ii -- area of common indent
Plug('kana/vim-textobj-line')           -- il
Plug('machakann/vim-textobj-delimited') -- id -- each delimited part of a camel/snake/kabob-case word
Plug('reedes/vim-textobj-quote')        -- iq -- curly quotes.
Plug('tek/vim-textobj-ruby')            -- if(unction), c(lass), and r for a block. an for a Scoped::Name
Plug('whatyouhide/vim-textobj-xmlattr') -- ix

-- UI Enhancements
Plug('rubik/vim-base16-paraiso')
Plug('arzg/vim-colors-xcode')
Plug('morhetz/gruvbox')
Plug('folke/tokyonight.nvim')
Plug('sonph/onehalf', { ['rtp'] = 'vim' })
Plug('lewis6991/gitsigns.nvim')         -- Diff markers in the gutter
Plug('bling/vim-airline')               -- Status
Plug('vim-airline/vim-airline-themes')

-- IDE-Like Behavior
Plug('tpope/vim-fugitive')       -- Git
Plug('tpope/vim-rhubarb')        -- GitHub
Plug('rizzatti/dash.vim')        -- Open the docs
Plug('tpope/vim-projectionist')  -- :Econtroller user
Plug('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })
Plug('junegunn/fzf.vim')
Plug('neovim/nvim-lspconfig')
Plug('ojroques/nvim-lspfuzzy')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
-- Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')
Plug('ntpeters/vim-better-whitespace') -- Highlight trailing whitespace
Plug('vim-scripts/Rename')
Plug('christoomey/vim-tmux-navigator')
if vim.fn.executable('shadowenv') == 1 then
  Plug('Shopify/shadowenv.vim')
end
Plug('janko/vim-test')
Plug('kevinhwang91/nvim-ufo')
Plug('kevinhwang91/promise-async') -- required by nvim-ufo
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('pwntester/octo.nvim')

-- AI
Plug('github/copilot.vim')

-- Language Support

-- Assembly
Plug('nviennot/vim-armasm')

-- Crystal
Plug('rhysd/vim-crystal')

-- CSS
Plug('hail2u/vim-css3-syntax')
-- Plug('gko/vim-coloresque') -- Highlight colors like #009bf9

-- Elixir
Plug('elixir-editors/vim-elixir')

-- Go
Plug('jnwhiteh/vim-golang')

-- HTML
Plug('alvan/vim-closetag')

-- Javascript etc.
Plug('othree/yajs.vim')
Plug('othree/es.next.syntax.vim')
Plug('mxw/vim-jsx')
Plug('Quramy/vim-js-pretty-template')
Plug('HerringtonDarkholme/yats.vim')
Plug('posva/vim-vue')
Plug('kchmck/vim-coffee-script')
Plug('jparise/vim-graphql')

-- Markdown
Plug('plasticboy/vim-markdown')

-- Liquid
Plug('tpope/vim-liquid')

-- Reason
Plug('reasonml-editor/vim-reason-plus')

-- Ruby
Plug('vim-ruby/vim-ruby')
Plug('tpope/vim-rails')
Plug('tpope/vim-bundler')
Plug('thoughtbot/vim-rspec')
Plug('noprompt/vim-yardoc')

-- TOML
Plug('cespare/vim-toml')

-- YAML
Plug('stephpy/vim-yaml')
Plug('pedrohdz/vim-yaml-folds')

-- Zig
Plug('ziglang/zig.vim')

vim.fn['plug#end']()

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

vim.g.NERDSpaceDelims = 1

-- UI enhancements
vim.cmd('syntax enable')

vim.opt.number = true           -- Show line number
vim.opt.relativenumber = true   -- Use relative line numbers
vim.opt.scrolloff = 7           -- Pad the edge of the screen
vim.opt.cmdheight = 2           -- Height of the command bar
vim.opt.hidden = true           -- A buffer becomes hidden when it is abandoned
vim.opt.showmatch = true        -- Show matching brackets when text indicator is over them
vim.opt.matchtime = 2           -- How many tenths of a second to blink when matching brackets
vim.opt.laststatus = 2          -- Always show statusline
vim.opt.colorcolumn = '121'     -- Show where 120 chars is
vim.opt.list = true             -- Show the below hidden characters
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

vim.opt.termguicolors = true
vim.cmd('colorscheme tokyonight-storm')
vim.opt.background = 'dark'
vim.g.airline_theme = 'lucius' -- 'lucius' is a good general-purpose theme

vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#branch#enabled'] = 1

vim.api.nvim_set_keymap('n', '[t', ':tabprevious<CR>', { silent = true })
vim.api.nvim_set_keymap('n', ']t', ':tabnext<CR>', { silent = true })

-- IDE-like behavior
vim.opt.ignorecase = true              -- Ignore case when searching
vim.opt.hlsearch = true                -- Highlight search results
vim.opt.incsearch = true               -- Search as I type
vim.opt.smartcase = true               -- When searching try to be smart about cases
vim.opt.wildmenu = true                -- Turn on the WiLd menu
vim.opt.wildignore = '*.o,*~,*.pyc'    -- Ignore compiled files
vim.opt.undofile = true                -- Persistent history between sessions

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

vim.api.nvim_set_keymap('n', '<leader>e', ':Explore<CR>', { noremap = true })

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

-- Dash
vim.api.nvim_set_keymap('n', 'K', ':Dash<CR>', { noremap = true, silent = true })

local cmp = require 'cmp'

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
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline({ '/', '?' }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- LSP
local lspconfig = require 'lspconfig'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

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
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
end

vim.lsp.set_log_level("info")
lspconfig.ruby_lsp.setup({
  on_attach = on_attach,
  init_options = {
    enabledFeatures = {
      semanticHighlighting = false
    },
    tapiocaAddon = true,
  },
})
lspconfig.sorbet.setup({ on_attach = on_attach })
lspconfig.rust_analyzer.setup({ on_attach = on_attach })
lspconfig.tsserver.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })
lspconfig.zls.setup { on_attach = on_attach, cmd = { 'zls' },
  settings = {
    zls = {
      enable_build_on_save = true,
    }
  }
 }

require('lspfuzzy').setup {
  methods = 'all',         -- either 'all' or a list of LSP methods (see below)
  jump_one = true,         -- jump immediately if there is only one location
  callback = nil,          -- callback called after jumping to a location
  fzf_preview = {          -- arguments to the FZF '--preview-window' option
    'right:+{2}-/2'          -- preview on the right and centered on entry
  },
  fzf_action = {           -- FZF actions
    ['ctrl-t'] = 'tabedit',  -- go to location in a new tab
    ['ctrl-v'] = 'vsplit',   -- go to location in a vertical split
    ['ctrl-x'] = 'split',    -- go to location in a horizontal split
  },
  fzf_modifier = ':~:.',   -- format FZF entries, see |filename-modifiers|
  fzf_trim = true,         -- trim FZF entries
}

-- Fold
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require('ufo').setup()

require('gitsigns').setup()

-- Octo
require'nvim-web-devicons'.setup()
require'octo'.setup()

-- Copilot
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  command = "execute ':Copilot disable'"
})

-- Fzf
-- Customize fzf colors to match your color scheme
-- - fzf#wrap translates this to a set of `--color` options
vim.g.fzf_colors = {
  fg = { 'fg', 'Normal' },
  bg = { 'bg', 'Normal' },
  hl = { 'fg', 'Comment' },
  ["fg+"] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ["bg+"] = { 'bg', 'CursorLine', 'CursorColumn' },
  ["hl+"] = { 'fg', 'Statement' },
  info = { 'fg', 'PreProc' },
  border = { 'fg', 'Ignore' },
  prompt = { 'fg', 'Conditional' },
  pointer = { 'fg', 'Exception' },
  marker = { 'fg', 'Keyword' },
  spinner = { 'fg', 'Label' },
  header = { 'fg', 'Comment' }
}

vim.api.nvim_set_keymap('n', '<c-p>', ':GFiles<CR>', { silent = true })
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

-- Vim Test
vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>tg', ':TestVisit<CR>', { silent = true })
vim.g['test#strategy'] = "dispatch"
vim.g.dispatch_tmux_pipe_pane = 1  -- needed so $stdout.tty? is true and reline works when debugging

-- Language support

-- Assembly
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
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

vim.g.splitjoin_trailing_comma = 1
vim.g.splitjoin_ruby_hanging_args = 0
vim.g.splitjoin_ruby_curly_braces = 0
vim.g.splitjoin_ruby_options_as_arguments = 1

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
