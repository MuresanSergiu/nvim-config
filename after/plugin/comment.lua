require('Comment').setup({
    ignore = '^$',
    opleader = {
        line = '<leader>t',
        block = '<leader>b',
    },
    toggler = {
        ---Line-comment toggle keymap
        line = '<leader>tt',
        ---Block-comment toggle keymap
        block = '<leader>bb',
    },
})
