return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    -- Customize what gets saved in sessions
    options = { 'buffers', 'curdir' },
    pre_save = function()
      -- Close all neo-tree windows
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == 'neo-tree' then
          vim.api.nvim_win_close(win, false)
        end
      end

      -- Delete neo-tree buffers
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == 'neo-tree' then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end,
  },
  keys = {
    -- load the session for the current directory
    vim.keymap.set('n', '<leader>qs', function()
      require('persistence').load()
    end),

    -- select a session to load
    vim.keymap.set('n', '<leader>qS', function()
      require('persistence').select()
    end),

    -- load the last session
    vim.keymap.set('n', '<leader>ql', function()
      require('persistence').load { last = true }
    end),

    -- stop Persistence => session won't be saved on exit
    vim.keymap.set('n', '<leader>qd', function()
      require('persistence').stop()
    end),
  },
}
