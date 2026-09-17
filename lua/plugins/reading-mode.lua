return {
  "gregates/reading-mode.nvim",
  lazy = true,
  keys = {
    { "<leader>z", function() require("reading_mode").toggle() end, desc = "Toggle reading mode" }
  },
  cmd = "ReadingMode",
  config = function()
    require("reading_mode").setup({ width = 80, vpad = 2 })
    vim.api.nvim_create_user_command("ReadingMode", function()
      require("reading_mode").toggle()
    end, { desc = "Toggle reading mode" })
  end
}
