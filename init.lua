-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ','

vim.keymap.set('i', '<leader><leader>', '<Esc>')
vim.keymap.set('n', '<leader><space>', ':noh<CR>', { desc = "Clear highlights" })
--- splits; ,v opens one; ,w is like alt-tab; ,hjkl moves around; ,q closes;
--- ,o makes current split the only one; ,p closes any preview window
vim.keymap.set('n', '<leader>v', '<C-w>v<C-w>l', { desc = "Split vertical" })
vim.keymap.set('n', '<leader>s', '<C-w>s<C-w>j', { desc = "Split horizontal" })
vim.keymap.set('n', '<leader>h', '<C-w>h', { desc = "Left window" })
vim.keymap.set('n', '<leader>j', '<C-w>j', { desc = "Lower window" })
vim.keymap.set('n', '<leader>k', '<C-w>k', { desc = "Upper window" })
vim.keymap.set('n', '<leader>l', '<C-w>l', { desc = "Right window" })
vim.keymap.set('n', '<leader>q', '<C-w>q', { desc = "Close window" })
vim.keymap.set('n', '<leader>o', '<C-w>o', { desc = "Close others" })
vim.keymap.set('n', '<leader>z', '<C-w>z:cclose<CR>', { desc = "Close preview", silent = true })
--- map arrow keys to forward/back, not navigation
vim.keymap.set('n', '<Left>', '<C-o>', { desc = "Jump back" })
vim.keymap.set('n', '<Right>', '<Tab>', { desc = "Jump forward" })
--- search with fzf
vim.keymap.set('n', [[\]], ':Rg<Cr>')
--vim.keymap.set('n', '<leader>f', ':Files<Cr>')
--vim.keymap.set('n', '<leader>g', ':GFiles<Cr>')
--vim.keymap.set('n', '<leader>b', ':Buffers<Cr>')
--- lsp keybindings
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set('n', '<leader>p', vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gc', vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>c', vim.lsp.buf.code_action, opts)
  end,
})
--- tab completion
vim.g.insert_tab_wrapper = function()
    local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('[%w%p]') == nil then
    return '<Tab>'
  else
    return '<C-x><C-o>'
  end
end
vim.keymap.set('i', '<Tab>', vim.g.insert_tab_wrapper, { expr = true, silent = true })

-- search options
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- basic appearance
require('tokyonight').setup({
  style = 'moon',
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  }
})
vim.cmd.colorscheme('tokyonight')
vim.o.number = false
vim.o.colorcolumn = '81'
vim.o.linespace = 1

-- tabs and spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.list = true
vim.o.listchars = 'tab:»·,trail:·'

-- don't try to restore <EOL> if it's missing, just keep things the same
vim.o.fixendofline = false

-- use treesitter for folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false

-- filetype specific settings
vim.cmd([[
  filetype plugin indent on
  autocmd Filetype ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype lua setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype haml setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype slim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype gitcommit setlocal textwidth=72 tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype rust setlocal textwidth=120 colorcolumn=121
  autocmd Filetype markdown setlocal colorcolumn=101 textwidth=100
  autocmd Filetype typescript setlocal colorcolumn=101
]])

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
