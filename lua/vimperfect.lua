local vim = vim

local function join_list(list, sep)
    local join_str = ''

    local first = true
    for _, word in pairs(list) do
        if first then
            join_str = word
            first = false
        else
            join_str = join_str .. sep .. word
        end
    end

    return join_str
end

local function shuffle_list(list)
    -- Fisher Yates Algorithm
    math.randomseed(os.time())

    local shuffled_list = vim.deepcopy(list)
    for i, el in pairs(list) do
        local j = math.random(#list - i, #list)
        shuffled_list[j] = el
    end

    return shuffled_list
end

local function randomize_line(line, seed)
    local randomize_funcs = {
        -- Functions that take in a list of words and return a list of words
        shuffle_list,
        function() return {} end,
        function(x) return x end,
    }

    math.randomseed(seed)
    local edit = math.random(1, #randomize_funcs)

    local split_line = vim.split(line, " ")
    return join_list(randomize_funcs[edit](split_line), " ")
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
