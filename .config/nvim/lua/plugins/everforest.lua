return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_background = "hard"
      vim.opt.background = "dark"
      vim.g.everforest_enable_italic = true
      vim.cmd("autocmd VimEnter * hi NeoTreeNormal guibg=NONE")
      vim.cmd("autocmd VimEnter * hi NeoTreeNormalNC guibg=NONE")
      vim.cmd("autocmd VimEnter * hi NeoTreeEndOfBuffer guibg=NONE")
      vim.cmd.colorscheme("everforest")
    end,
  },
}
