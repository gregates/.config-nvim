return {
  "echasnovski/mini.files",
  version = '*',
  keys = {
    {
      "<leader>f",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Browse @file",
    },
    {
      "<leader>F",
      function()
        require("mini.files").open(vim.un.cwd(), true)
      end,
      desc = "Browse @cwd",
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)
  end,
}
