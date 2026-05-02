return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              pythonPath = ".venv/bin/python",
            },
          },
        },
      },
    },
  },
}
