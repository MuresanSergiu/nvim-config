local lsp = require('lsp-zero')
-- lsp.preset('minimal')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'ts_ls',
        'angularls',
        'rust_analyzer',
        'lua_ls',
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})

-- local cmp = require('cmp')
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
-- })
local cmp = require('cmp')
local cmp_format = lsp.cmp_format({details = true})
cmp.setup({
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

-- cmp.setup.filetype({ 'mysql', 'pgsql', 'sql' }, {
--     sources = {
--         { name = 'vim-dadbod-completion' },
--         { name = 'buffer' }
--     }
-- })

-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings,
-- })


function get_current_line_diagnostics()
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local diagnostics = vim.diagnostic.get(bufnr, { lnum = row - 1 })
  local lsp_diagnostics = vim.tbl_map(function(value)
    local diagnostic = {
      code = value.code,
      message = value.message,
      severity = value.severity,
      source = value.source,
      range = {
        start = {
          character = value.col,
          line = value.lnum,
        },
        ["end"] = {
          character = value.end_col,
          line = value.end_lnum,
        }
      }
    }
    local lsp_data = vim.tbl_get(value, "user_data", "lsp")

    if lsp_data then
      diagnostic.codeDescription = lsp_data.codeDescription
      diagnostic.tags = lsp_data.tags
      diagnostic.relatedInformation = lsp_data.relatedInformation
      diagnostic.data = lsp_data.data
    end

    return diagnostic
  end, diagnostics)

  return lsp_diagnostics
end

function range_from_selection (bufnr, mode)
  local start = vim.fn.getpos("v")
  local end_ = vim.fn.getpos(".")
  local start_row = start[2]
  local start_col = start[3]
  local end_row = end_[2]
  local end_col = end_[3]

  -- A user can start visual selection at the end and move backwards
  -- Normalize the range to start < end
  if start_row == end_row and end_col < start_col then
    end_col, start_col = start_col, end_col
  elseif end_row < start_row then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end
  if mode == "V" then
    start_col = 1
    local lines = vim.api.nvim_buf_get_lines(bufnr, end_row - 1, end_row, true)
    end_col = #lines[1]
  end
  return {
    ["start"] = { start_row, start_col - 1 },
    ["end"] = { end_row, end_col - 1 },
  }
end

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    lsp.default_keymaps({buffer = bufnr})

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, opts)
    vim.keymap.set({ 'n', 'x', 'v' }, '<leader>ca', function()
        -- local row = vim.api.nvim_win_get_cursor(0)[1]
        -- local params = vim.lsp.util.make_given_range_params({ row, 0 }, { row, 500 })
        -- print(vim.inspect(params))
        -- params.apply = true
        vim.lsp.buf.code_action()
        -- vim.defer_fn(function () vim.cmd('w') end, 2000)
    end, opts)
    vim.keymap.set({ 'n', 'x', 'v' }, '<leader>ci', function()
        -- local diags = vim.diagnostic.get(0)
        -- print(vim.inspect(diags))
        local range = range_from_selection(0, vim.api.nvim_get_mode().mode)
        local params = vim.lsp.util.make_range_params()


        print("---------")
        -- local params = vim.lsp.util.make_range_params()
        -- local params = {}

        params.context = {
            triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
            diagnostics = vim.diagnostic.get(0),
        }
        local diags = vim.diagnostic.get(0)
        params.context.diagnostics = {}
        for k, v in ipairs(diags) do
            -- print(v.message)
            if v.message:find("^consider importing") then
                table.insert(params.context.diagnostics, v)
            end
        end
        -- print(vim.inspect(params))

        vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function (error, results, context)
            if error then
                print(error)
                return
            end
            print(vim.inspect(results))
            for k, v in ipairs(results) do
                print(vim.inspect(v.text))
                print(vim.inspect(v.kind))
            end
        end)
        -- local name = vim.api.nvim_buf_get_name(0)
        -- local inspect = require('inspect')
        -- inspect(vim.lsp.get_active_clients()[1].server_capabilities)
        -- vim.lsp.buf_request_sync()
    end, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<C-n>', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true }) end)
    vim.keymap.set('n', '<C-h>', function() vim.diagnostic.goto_next({ wrap = true }) end)
    vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '<leader>pe', function () vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR }) end, {})
    vim.keymap.set('n', '<leader>pw', function () vim.diagnostic.setqflist() end, {})
end)

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({
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

lspconfig.pylsp.setup({
    pylsp = {
        plugins = {
            pycodestyle = {
                ignore = {'W391'},
                maxLineLength = 100
            }
        }
    }
})
lspconfig.emmet_language_server.setup({
    filetypes = { "html", "php", "htmlangular" },
    init_options = {
        showSuggestionsAsSnippets = true,
        showAbbreviationSuggestions = false,
    }
})
-- print(vim.inspect(capabilities))
-- lspconfig.rust_analyzer.setup({
--     settings = {
--         ['rust-analyzer'] = {
--             checkOnSave = {
--                 allFeatures = true,
--                 overrideCommand = {
--                     'cargo', 'clippy', '--workspace', '--message-format=json',
--                     '--all-targets', '--all-features'
--                 }
--             }
--         }
--     }
-- })
-- lsp.setup()

--
-- lspconfig.emmet_ls.setup({
--     -- on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
--     init_options = {
--       html = {
--         options = {
--           -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
--           ["bem.enabled"] = true,
--         },
--       },
