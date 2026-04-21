return {
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>tn", "<cmd>TestNearest<cr>", desc = "nearest test" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "test file" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "last test" },
      { "<leader>tv", "<cmd>TestVisit<cr>", desc = "visit test output" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
    end,
  },
}
