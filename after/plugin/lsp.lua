vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename)
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'single' }) end)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<C-n>', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true }) end)
vim.keymap.set('n', '<C-h>', function() vim.diagnostic.goto_next({ wrap = true }) end)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>pe', function () vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR }) end, {})
vim.keymap.set('n', '<leader>pw', function () vim.diagnostic.setqflist() end, {})
-- vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)
vim.keymap.set({ 'n', 'x', 'v' }, '<leader>ca', function()
    -- local row = vim.api.nvim_win_get_cursor(0)[1]
    -- local params = vim.lsp.util.make_given_range_params({ row, 0 }, { row, 500 })
    -- print(vim.inspect(params))
    -- params.apply = true
    vim.lsp.buf.code_action()
    -- vim.defer_fn(function () vim.cmd('w') end, 2000)
end)

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.config('pylsp', {
    pylsp = {
        plugins = {
            pycodestyle = {
                ignore = {'W391'},
                maxLineLength = 100
            }
        }
    }
})
vim.lsp.config('emmet_language_server', {
    filetypes = { "html", "php", "htmlangular" },
    init_options = {
        showSuggestionsAsSnippets = true,
        showAbbreviationSuggestions = false,
    }
})
vim.lsp.enable('lua_ls')
vim.lsp.enable('pylsp')
vim.lsp.enable('emmet_language_server')
vim.lsp.enable('rust_analyzer');
vim.lsp.enable('ts_ls');
vim.lsp.enable('angularls');
vim.lsp.enable('cssls');
vim.lsp.enable('intelephense');
