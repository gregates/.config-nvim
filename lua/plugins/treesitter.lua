return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- the main branch does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    -- Parsers are compiled locally with the tree-sitter CLI and a C compiler.
    -- Already-installed parsers are skipped.
    local install = require("nvim-treesitter").install
    if vim.fn.executable("tree-sitter") == 0 then
      vim.notify("nvim-treesitter: tree-sitter CLI not found, not installing parsers", vim.log.levels.WARN)
      install = function() end
    end
    install({
      'bash',
      'c',
      'diff',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'luadoc',
      'luap',
      'markdown',
      'markdown_inline',
      'printf',
      'python',
      'query',
      'regex',
      'ruby',
      'rust',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    })

    -- The plugin only installs parsers and queries; turning features on is up to us.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", {}),
      callback = function(ev)
        -- fails when there is no parser for this filetype
        if not pcall(vim.treesitter.start, ev.buf) then
          return
        end
        local lang = vim.treesitter.language.get_lang(ev.match)
        if lang and vim.treesitter.query.get(lang, "indents") then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- Incremental selection is built into nvim now, as an/in in visual mode.
    vim.keymap.set("n", "<space>", "van", { remap = true, desc = "Select treesitter node" })
    vim.keymap.set("x", "<space>", "an", { remap = true, desc = "Expand selection to parent node" })
    vim.keymap.set("x", "<BS>", "in", { remap = true, desc = "Shrink selection to child node" })
  end,
}
