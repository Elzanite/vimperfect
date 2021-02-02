local vim = vim

local function randomize_line(line, seed)
    math.randomseed(seed)
    local edit_id = math.random(1, 10)

    local modified_line = line

    if edit_id > 5 then
        modified_line = 'modified'
    else
        modified_line = line
    end

    return modified_line
end

local function randomize_buffer(lines)
    local new_lines = lines
    for i, line in pairs(lines) do
        new_lines[i] = randomize_line(line, i + os.time())
    end

    return new_lines
end

local function vimperfect()

    local current_buffer_filetype = vim.fn.nvim_buf_get_option(0, 'filetype')
    local current_buffer_lines = vim.fn.nvim_buf_get_lines(0, 0, -1, true)
    local new_buffer = vim.fn.nvim_create_buf(true, true)

    -- Set new buffer that is a copy of the current buffer to display in current window
    vim.fn.nvim_buf_set_lines(new_buffer, 0, -1, true, randomize_buffer(current_buffer_lines))
    vim.fn.nvim_buf_set_option(new_buffer, 'filetype', current_buffer_filetype)
    vim.fn.nvim_win_set_buf(0, new_buffer)
end



return {
    vimperfect = vimperfect
}
