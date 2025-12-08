vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>th", "<cmd>bp<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>bn<CR>")


vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })


vim.keymap.set("n", "K", vim.lsp.buf.hover)

-- register a command that recursively runs the lsp formatter on every file ending in .lua

vim.api.nvim_create_user_command("LuaFormat", function()
    local files = vim.fn.globpath(vim.fn.getcwd(), "**/*.lua")
    if not files or #files == 0 then
        print("No lua files found")
        return
    end

    local filesTbl = vim.split(files, "\n")

    for _, file in ipairs(filesTbl) do
        vim.cmd("e " .. file)
        vim.lsp.buf.format()
    end
end, { nargs = 0, })
