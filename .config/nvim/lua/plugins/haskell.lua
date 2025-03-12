return {
  { "neovimhaskell/haskell-vim" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        hls = function()
          return false
        end,
      },
    },
  },
}
