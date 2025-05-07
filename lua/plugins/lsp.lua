return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lsp = require("lspconfig")

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "declaration" })
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "definition" })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover tooltip" })
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "implementation" })
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "references" })
          vim.keymap.set('n', 'gc', vim.lsp.buf.incoming_calls, { buffer = ev.buf, desc = "incoming calls"})
          vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "signature help" })
          vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "type definition" })
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
          vim.keymap.set({ 'n', 'v' }, '<leader>c', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
        end,
      })

      require('mason').setup({})
      require('mason-lspconfig').setup({
        handlers = {
          function(server)
            lsp[server].setup({})
          end,
        },
      })
    end,
  },
}
