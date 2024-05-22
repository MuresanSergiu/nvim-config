local dap = require('dap')
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = {"/home/afterwind/Programs/js-debug/src/dapDebugServer.js", "${port}"},
    }
}
dap.configurations.javascript = {
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach server",
        restart = true,
        cwd = "${workspaceFolder}",
        port = 9229,
    },
}
dap.configurations.typescript = {
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach server",
        restart = true,
        cwd = "${workspaceFolder}",
        port = 9229,
    },
}

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<leader>dB', function() 
    require('dap').clear_breakpoints()
    print("Cleared breakpoints!")
end)
vim.keymap.set({'n', 'v'}, '<leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)
