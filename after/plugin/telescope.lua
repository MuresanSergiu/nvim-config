local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pl', function() builtin.oldfiles({
    cwd_only = true,
}) end, {})
vim.keymap.set({'n', 'i', 's', 'x'}, '<C-p>', function() builtin.git_files({ show_untracked = true }) end, {})
vim.keymap.set('n', '<leader>pp', function() builtin.git_files({ show_untracked = true }) end, {})
vim.keymap.set('n', '<leader>pf', function() builtin.find_files({ no_ignore = true, hidden = true }) end, {})
vim.keymap.set('n', '<leader>po', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>pt', builtin.lsp_workspace_symbols, {})

vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ff', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>fr", builtin.resume, { noremap = true, silent = true, desc = "Resume", })

local previewers = require("telescope.previewers")
local Job = require("plenary.job")
-- local new_maker = function(filepath, bufnr, opts)
--     filepath = vim.fn.expand(filepath)
--     Job:new({
--         command = "file",
--         args = { "--mime-type", "-b", filepath },
--         on_exit = function(j)
--                 previewers.buffer_previewer_maker(filepath, bufnr, opts)
--             -- local mime_type = vim.split(j:result()[1], "/")[1]
--             -- if mime_type == "text" or j:result()[1] == "application/json" then
--             --     previewers.buffer_previewer_maker(filepath, bufnr, opts)
--             -- else
--             --     -- maybe we want to write something to the buffer here
--             --     vim.schedule(function()
--             --         vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
--             --     end)
--             -- end
--         end
--     }):sync()
-- end

local actions = require("telescope.actions")
local telescope = require('telescope')
telescope.setup({
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
        },
        buffer_previewer_maker = new_maker,
        file_ignore_patterns = {
            '\\.angular', "node_modules", "build/", "dist", "yarn.lock"
        },
        mappings = {
            i = {
                ["<Up>"] = actions.nop,
                ["<Down>"] = actions.nop,
                -- ["<esc>"] = actions.close
            },
        },
        preview = {
            -- treesitter = {enable = true, disable = {'typescript'}},
        },
        
        extensions = { "fzf" }
    }
})
telescope.load_extension("fzf")
