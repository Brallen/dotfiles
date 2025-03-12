return {
  {
    "gleam-lang/gleam.vim",
    ft = "gleam",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gleam" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gleam = { mason = false },
      },
    },
  },
}
