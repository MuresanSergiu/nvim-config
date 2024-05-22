function ColorMyPencils(color)
    -- vim.g.codedark_conservative = 0
    -- vim.g.codedark_modern = 1
    -- vim.g.codedark_italics = 1
    -- vim.g.codedark_theme256 = 1
    color = color or "onedark"
    -- color = color or "vscode"
    vim.cmd.colorscheme(color)

    if color == "vscode" then
        vim.o.background = 'dark'
        local vscode = require('vscode')
        vscode.setup({
            style = 'dark',
            italic_comments = true
        })
        vscode.load()
    elseif color == "onedark" then
        require('onedark').setup {
            style = 'darker',
            highlights = {
                IblIndent = { fg = "$bg3", fmt = "nocombine" },
                IblWhitespace = { fmt = "nocombine" },
                IblScope = { fmt = "nocombine" },
                IndentBlanklineContextChar = { fg = "$light_grey", fmt = "nocombine" },
                IndentBlanklineContextStart = { sp = "$light_grey", fmt = "nocombine,underline" },
            }
        }
        require('onedark').load()
    end

--    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
-- 
