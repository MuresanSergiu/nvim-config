require('gitsigns').setup({
    preview_config = {
        border = 'single'
    },
    on_attach = function (bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>gh', gs.preview_hunk)
        map('n', '<leader>gr', gs.reset_hunk)
        map('n', '<leader>gd', gs.diffthis)
        map('n', '<C-Y>', function() gs.nav_hunk('next', { wrap = true }) end)
        -- map('n', '<leader>gc', function () gs.blame_line({ full = true }) end)
        -- map('n', '<leader>gb', gs.toggle_current_line_blame)
    end
})
