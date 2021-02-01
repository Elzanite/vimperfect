local vim = vim

local function vimperfect()
    print("Start Vimperfect")
    print(vim.fn.nvim_get_current_line())
    return 0
end



return {
    vimperfect = vimperfect
}
