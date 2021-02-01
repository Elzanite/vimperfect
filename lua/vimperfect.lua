local function vimperfect()
    vim.register_keystroke_callback(function()
        print('Key press')
    end)
    return 0
end



return {
    vimperfect = vimperfect
}
