-- my own modules

-- create command TODO
vim.api.nvim_create_user_command('Todo', 'normal! iTODO: | @d | @p | @t | @f | <Esc>0f:', {})
--

-- Function to insert today's date in YYYY-MM-DD format
local function insert_today_date()
  local date_str = tostring(os.date '%Y-%m-%d')
  vim.api.nvim_put({ date_str }, 'c', true, true)
end

-- Create custom command to insert today
vim.api.nvim_create_user_command('Today', insert_today_date, {})
--
-- Function to replace "TODO" with "DONE" and move the line to the end of the document
local function replace_todo_with_done_and_move()
  -- Get the current line content
  local line = vim.api.nvim_get_current_line()

  -- Replace "TODO" with "DONE"
  local new_line = line:gsub('TODO', 'DONE')

  -- Set the modified line
  vim.api.nvim_set_current_line(new_line)

  -- Delete the current line
  vim.api.nvim_del_current_line()

  -- Append the modified line to the end of the document
  vim.api.nvim_buf_set_lines(0, -1, -1, false, { new_line })
end

-- Create the :Done command
vim.api.nvim_create_user_command('Done', replace_todo_with_done_and_move, {})

-- Hightlight TODO in markdown files
vim.cmd [[
  augroup MarkdownHighlight
    autocmd!
    autocmd FileType markdown syntax match TodoKeyword /\CTODO/
    autocmd FileType markdown highlight link TodoKeyword TodoBgNOTE
  augroup END
]]

return {}
