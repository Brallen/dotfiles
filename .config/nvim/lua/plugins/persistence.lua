return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    options = { 'buffers', 'curdir' },
    -- Neo-tree windows do not restore cleanly, so drop them before the session is written
    pre_save = function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == 'neo-tree' then
          vim.api.nvim_win_close(win, false)
        end
      end

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == 'neo-tree' then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end,
  },
  -- stylua: ignore
  keys = {
    { '<leader>qs', function() require('persistence').load() end, desc = 'Restore Session' },
    { '<leader>qS', function() require('persistence').select() end, desc = 'Select Session' },
    { '<leader>ql', function() require('persistence').load { last = true } end, desc = 'Restore Last Session' },
    { '<leader>qd', function() require('persistence').stop() end, desc = "Don't Save Current Session" },
  },
}
