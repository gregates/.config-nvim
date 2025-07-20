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

vim.cmd.colorscheme("tokyonight")
