-- line numbers
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.showcmd = true

-- tabs and indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
-- vim.opt.termguicolors = true
vim.opt.wrap = false

vim.g.copilot_no_tab_map = true
vim.g.copilot_enabled = true

vim.opt.title = true
vim.opt.titlelen = 0

local maxPathLength = 35
local titlePrefix = "vim "

function CustomTitleString()
    local workingDir = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
    if #workingDir < maxPathLength then
        return titlePrefix .. workingDir
    end

    local parts = vim.split(workingDir, "/")

    local newParts = {}
    local newLength = 0
    for i = #parts, 1, -1 do
        newLength = newLength + #parts[i] + 1
        if newLength > maxPathLength and #newParts > 0 then
            table.insert(newParts, 1, "...")
            break
        end
        table.insert(newParts, 1, parts[i])
    end

    return titlePrefix .. table.concat(newParts, "/")
end

vim.opt.titlestring = "%{v:lua.CustomTitleString()}"
