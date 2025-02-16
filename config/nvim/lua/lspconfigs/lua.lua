if vim.fn.isdirectory("lua/autorun") == 1 then
    return {
        settings = {
            Lua = {
                workspace = {
                    maxPreload = 10000000,
                    library = {
                        vim.fn.expand("$HOME/LuaLibs/glua"),
                    },
                    checkThirdParty = false
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
                    nonstandardSymbol = {
                        "!",
                        "!=",
                        "&&",
                        "||",
                        "//",
                        "/**/",
                        "continue"
                    },
                    version = "LuaJIT",
                }
            }
        }
    }
else
    return {
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false
                }
            }
        }
    }
end
