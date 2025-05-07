return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { 'mode', 'paste' },
        lualine_b = { 'diagnostics' },
        lualine_c = { { 'filename', file_status = true, path = 1 } },
        lualine_x = { 'lsp_status' },

        lualine_y = { 'location', 'progress' },
        lualine_z = { 'fileformat', 'encoding', 'filetype' },
      },
    }
  },
}
