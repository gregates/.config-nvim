return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    preset = "helix",
    spec = {
      {
        mode = { "n", "v" },
        { ",", desc = "," },
        { "<leader><leader>", "<Esc>" },
        { "<leader><space>", ":noh<CR>", desc = "Clear highlights" },
        { "<leader>h", "<c-w>h", desc = "Window left" },
        { "<leader>l", "<c-w>l", desc = "Window right" },
        { "<leader>k", "<c-w>k", desc = "Window up" },
        { "<leader>j", "<c-w>j", desc = "Window down" },
        { "<leader>q", "<c-w>q", desc = "Window close" },
        { "<leader>v", "<c-w>v<c-w>w", desc = "Split vertical" },
        { "g", group = "goto" },
        { "z", group = "fold" },
        { "<leader>b", group = "buffers", expand = function()
            return require("which-key.extras").expand.buf()
          end
        },
        { "<leader>w", group = "windows", expand = function()
            return require("which-key.extras").expand.win()
          end,
          proxy = "<c-w>",
        },
      }
    },
  },
  keys = {
     {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

