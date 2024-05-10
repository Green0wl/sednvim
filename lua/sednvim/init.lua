local M = {}

--- @param str string String to pass into GNU sed.
M.sedcmd_exec = function(str)
  local job = require 'plenary.job'
  local curr_buffnr = vim.fn.bufnr()

  job:new({
    command = 'sed',
    args = { str },
    on_exit = function(j, exit_code)
      if exit_code ~= 0 then
        M.handle_unexpected(exit_code)
        return
      end

      vim.schedule(function()
        vim.api.nvim_buf_set_lines(curr_buffnr, 0, -1, true, j:result())
      end)
    end,
    writer = vim.api.nvim_buf_get_lines(curr_buffnr, 0, -1, true)
  }):start()
end

--- @param exit_code integer
function M.handle_unexpected(exit_code)
  local notify_available = pcall(function() require("notify") end)

  local err_msg = ("Unexpected exit code: %s."):format(exit_code)
  if notify_available then
    vim.schedule(function()
      require("notify")(err_msg, "error", {
        title = "sednvim",
        render = "compact"
      })
    end)
    return
  end
  print(("Unexpected exit code: %s."):format(exit_code))
end

M.sedcmd_input = function()
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  local popup_options = {
    position = "50%",
    size = 40,
    border = {
      style = "rounded",
      text = {
        top = "[GNU sed]",
        top_align = "left",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  }

  local input = Input(popup_options, {
    prompt = "> ",
    on_close = function() end,
    on_submit = function(value)
      M.sedcmd_exec(value)
    end,
    on_change = function(_) end,
  })

  input:mount()

  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return M
