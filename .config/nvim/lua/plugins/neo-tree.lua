return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    {
      '<leader>fE',
      function()
        require('neo-tree.command').execute { toggle = true, dir = '~' }
      end,
      desc = 'Explorer NeoTree (Root Dir)',
    },
    {
      '<leader>fe',
      function()
        require('neo-tree.command').execute { toggle = true, dir = vim.uv.cwd() }
      end,
      desc = 'Explorer NeoTree (cwd)',
    },
    { '<leader>e', '<leader>fe', desc = 'Explorer NeoTree (Root Dir)', remap = true },
    { '<leader>E', '<leader>fE', desc = 'Explorer NeoTree (cwd)', remap = true },
    {
      '<leader>ge',
      function()
        require('neo-tree.command').execute { source = 'git_status', toggle = true }
      end,
      desc = 'Git Explorer',
    },
    {
      '<leader>be',
      function()
        require('neo-tree.command').execute { source = 'buffers', toggle = true }
      end,
      desc = 'Buffer Explorer',
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)

    -- Disable mini.statusline in Neo-tree buffer
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'neo-tree',
      callback = function(args)
        vim.b[args.buf].ministatusline_disable = true
      end,
    })

    -- Auto-close Neo-tree if it's the only buffer left
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('NeoTreeClose', { clear = true }),
      pattern = '*',
      callback = function()
        local layout = vim.api.nvim_call_function('winlayout', {})
        if layout[1] == 'leaf' and vim.bo[vim.api.nvim_win_get_buf(layout[2])].filetype == 'neo-tree' and layout[3] == nil then
          vim.cmd 'quit'
        end
      end,
    })
  end,
  opts = {
    sources = { 'filesystem', 'buffers', 'git_status' },
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      filtered_items = {
        visible = true,
      },
      window = {
        mappings = {
          ['<leader>e'] = 'close_window',
        },
      },
    },
    window = {
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<space>'] = 'none',
        ['Y'] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg('+', path, 'c')
          end,
          desc = 'Copy Path to Clipboard',
        },
        ['P'] = { 'toggle_preview', config = { use_float = false } },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      git_status = {
        symbols = {
          unstaged = '󰄱',
          staged = '󰱒',
        },
      },
    },
  },
}
