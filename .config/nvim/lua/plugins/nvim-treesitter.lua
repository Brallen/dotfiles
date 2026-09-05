return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter', -- Sets main module to use for opts
  opts = {
    ensure_installed = {
      'astro',
      'bash',
      'c',
      'diff',
      'gleam',
      'haskell',
      'html',
      'javascript',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
}
