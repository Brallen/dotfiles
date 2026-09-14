local ensure_installed = {
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
}

return {
  'nvim-treesitter/nvim-treesitter',
  -- The `main` branch has no `configs` module; highlighting and indent are enabled per buffer below.
  -- Parsers are compiled locally, so the `tree-sitter` CLI and a C compiler must be on PATH.
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install(ensure_installed)

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-attach', { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang or not vim.treesitter.language.add(lang) then
          return
        end
        vim.treesitter.start(args.buf, lang)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
