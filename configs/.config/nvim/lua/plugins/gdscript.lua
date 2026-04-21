return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        gdscript = { "gdformat" },
      },
      formatters = {
        gdformat = {
          prepend_args = { "--use-spaces=4" },
        },
      },
    },
  },
  -- Disable LSP formatting for gdscript so conform wins
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {
          on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
    },
  },
}
