require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.fn.expand("$HOME/LuaLibs/glua/")
                }
            },
            hint = {
                enable = false
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                    tab_width = "4",
                    quote_style = "double",
                    max_line_length = "200",
                    insert_final_newline = "true",
                    space_inside_function_call_parentheses = "true",
                    space_inside_function_param_list_parentheses = "true",
                    space_inside_parethenses = "true",
                    align_continuous_inline_comment = "false",
                },
            },
            diagnostics = {
                groupFileStatus = {
                    -- strong = "Any",
                    strict = "Any"
                },
            },
            runtime = {
                special = {
                    include = "require"
                },
                version = "LuaJIT",
            }
        }
    }
})

vim.fn.jobstart("git pull origin main --recurse-submodules", { cwd = vim.fn.expand("$HOME/LuaLibs/glua") })
