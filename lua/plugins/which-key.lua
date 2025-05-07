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
        { "<leader>b", group = "buffers", expand = function()
            return require("which-key.extras").expand.buf()
          end
        },
      }
    },
    win = {
        title = false,
    },
  },
  keys = {
    --[[
     {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    --]]
  },
}
