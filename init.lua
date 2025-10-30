vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',

    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/tpope/vim-surround',
    'https://github.com/tpope/vim-abolish',
    'https://github.com/tpope/vim-dadbod',
    'https://github.com/kristijanhusak/vim-dadbod-ui',
    'https://github.com/kristijanhusak/vim-dadbod-completion',

    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
    'https://github.com/navarasu/onedark.nvim',
    'https://github.com/echasnovski/mini.ai',
    'https://github.com/numToStr/Comment.nvim',
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/nvim-lualine/lualine.nvim',

    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/L3MON4D3/LuaSnip',
})
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.lazyredraw = true
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.synmaxcol = 300
vim.opt.signcolumn = 'yes:1'
vim.opt.winborder = 'single'

-- vim.opt.shada = "NONE"
-- vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver40,r-cr-o:hor20'

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = "160"
vim.opt.showtabline = 0

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.undofile = true                            -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory

-- vim.opt.iskeyword:append("-")
vim.opt.path:append("**")                          -- include subdirectories in search

vim.g.mapleader = ' '
vim.g.db_ui_execute_on_save = false
vim.g.db_ui_use_nerd_fonts = true
vim.g.ftplugin_sql_omni_key = '<C-S>'
vim.g.c_syntax_for_h = true

vim.fn.setreg("o", "_f:laOption<" .. string.char(3) .. "$i>", "c")
--
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('i', '<Escape>', '<nop>')
vim.keymap.set('v', '<Escape>', '<nop>')
vim.keymap.set('n', '<C-s>', ':w<CR>')

-- Move cursor where it's supposed to be
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'gd', 'gdzzzv')

vim.keymap.set('v', '<C-j>', "J")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-Down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<S-Up>', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<M-h>', '<C-w><');
vim.keymap.set('n', '<M-j>', '<C-w>+');
vim.keymap.set('n', '<M-k>', '<C-w>-');
vim.keymap.set('n', '<M-l>', '<C-w>>');
vim.keymap.set('n', '<C-M-h>', '10<C-w><');
vim.keymap.set('n', '<C-M-j>', '10<C-w>+');
vim.keymap.set('n', '<C-M-k>', '10<C-w>-');
vim.keymap.set('n', '<C-M-l>', '10<C-w>>');

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })


-- vim.keymap.set('n', '<M-Left>', '<C-o>');
-- vim.keymap.set('n', '<M-Right>', '<C-i>');

vim.keymap.set({'c'}, '<C-k>', '<Up>');
vim.keymap.set({'c'}, '<C-j>', '<Down>');

vim.keymap.set({'i', 'n', 'x'}, '<Left>', '<nop>');
vim.keymap.set({'i', 'n', 'x'}, '<Right>', '<nop>');
vim.keymap.set({'i', 'n', 'x'}, '<Up>', '<nop>');
vim.keymap.set({'i', 'n', 'x'}, '<Down>', '<nop>');
vim.keymap.set({'n', 'x'}, 'H', '<nop>');
vim.keymap.set({'n', 'x'}, 'L', '<nop>');
vim.keymap.set('n', '<CR>', '<nop>');

vim.keymap.set('n', '<leader>/', ':let @/ = ""<CR>');
vim.keymap.set('v', '<leader>c', ':!sh<CR>');
vim.keymap.set('v', '<leader>sc', ':s/\\u/_\\l&/g<_c_r>:let @/ = ""<_c_r>');


-- For making macro execution extra fast...
-- Took wayyy too long to figure this out but, remember that when executing a command you remain in the same mode you are in so macros execute differently
vim.keymap.set('n', '@', function ()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.filetype.match({ buf = buf })
    vim.bo.filetype = ""
    vim.cmd("noautocmd norm! " .. (vim.v.count or 1) .. "@" .. vim.fn.getcharstr())
    vim.bo.filetype = ft
end, {})
vim.keymap.set({'v', 'x'}, '@', function ()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.filetype.match({ buf = buf })
    local reg = vim.fn.getcharstr()
    vim.bo.filetype = ""
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "x", false)
    vim.cmd("noautocmd \'<,\'>norm! " .. (vim.v.count or 1) .. "@" .. reg)
    vim.bo.filetype = ft
end, {})

vim.cmd('ca S Subvert')
vim.api.nvim_create_user_command('Build', '!rm extension.xpi; npx webpack && zip -r extension.xpi dist/ manifest.json && cp -f extension.xpi ~/Development/test', {});
vim.api.nvim_create_user_command('W', 'w', {});
vim.api.nvim_create_user_command('DBS', 'tabnew | DBUI', {})
vim.api.nvim_create_user_command('TODO', 'vsplit | wincmd l | edit TODO', {})
vim.api.nvim_create_user_command('TODOH', 'vsplit | wincmd l | edit ~/todo', {})

-- I don't care if this throws
pcall(function ()
    vim.api.nvim_del_user_command('EditQuery')
end)
-- vim.keymap.set('v', '<leader>cc', ':s/_\\w/\\u&/g<CR>:let @/ = ""<CR>');

-- this_is_a_test
-- vim.keymap.set('n', 'dsf', 'ds)dB', { silent = true });
-- vim.keymap.set('i', '<BS>', '<nop>');

-- vim.keymap.set('i', '{', '{<C-CR>}=kjkA<C-CR>');
-- vim.keymap.set('i', '(', '()i');
-- vim.keymap.set('i', '[', '[]i');
-- vim.keymap.set('i', '\'', '\'\'');
-- vim.keymap.set('i', '"', '""');

-- NOTE: donot trigger autocmd when executing macro
-- https://www.reddit.com/r/neovim/comments/tsol2n/comment/i2ugipm/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- vim.cmd([[
--   xnoremap @ :<C-U>execute "set ft= \| noautocmd '<,'>norm! " . v:count1 . "@" . getcharstr() . " \| filetype detect"<cr>
--   nnoremap @ <cmd>execute "set ft= \| noautocmd norm! " . v:count1 . "@" . getcharstr() . " \| filetype detect"<cr>
-- ]])

vim.cmd('autocmd FileType sql,mysql,plsql lua require(\'cmp\').setup.buffer({ sources = {{ name = \'vim-dadbod-completion\' }} })');
vim.cmd('autocmd FileType dbout setlocal nofoldenable')
vim.cmd('autocmd FileType mysql vnoremap <buffer> <CR> <Plug>(DBUI_ExecuteQuery)')
vim.cmd('autocmd FileType sql vnoremap <buffer> <CR> <Plug>(DBUI_ExecuteQuery)')
vim.cmd('autocmd FileType pgsql vnoremap <buffer> <CR> <Plug>(DBUI_ExecuteQuery)')
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "dbout",
--     callback = function ()
--         local buf = vim.api.expand('<abuf>')
--         local filetype_stuff = vim.api.nvim_buf_get_option(buf, "filetype")
--         vim.api.nvim_buf_set_option(buf, "filetype", filetype_stuff .. " setlocal nofoldenable")
--     end
-- })
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"",false)
        end
    end
})

vim.filetype.add({
    pattern = {
        ['.*%.rest'] = 'json',
        ['.*%.tpl'] = 'html',
    }
})

-- The Best Plugin
--- Angular component navigation
vim.keymap.set('n', '<leader>h', function()
    local file = vim.fn.expand('%')
    local file, ext = file:match('(.*)%.(.*)')
    if vim.fn.filereadable(file .. '.html') == 1 then
        vim.cmd('e ' .. file .. '.html')
        return
    end
    print("No html counterpart found for " .. file)
end)

vim.keymap.set('n', '<leader>s', function()
    local file = vim.fn.expand('%')
    local file, ext = file:match('(.*)%.(.*)')
    if vim.fn.filereadable(file .. '.scss') == 1 then
        vim.cmd('e ' .. file .. '.scss')
        return
    end
    if vim.fn.filereadable(file .. '.css') == 1 then
        vim.cmd('e ' .. file .. '.css')
        return
    end
    print("No style counterpart found for " .. file)
end)

vim.keymap.set('n', '<leader>j', function()
    local file = vim.fn.expand('%')
    local file, ext = file:match('(.*)%.(.*)')
    if vim.fn.filereadable(file .. '.ts') == 1 then
        vim.cmd('e ' .. file .. '.ts')
        return;
    end
    if vim.fn.filereadable(file .. '.js') == 1 then
        vim.cmd('e ' .. file .. '.js')
        return;
    end
    print("No script counterpart found for " .. file)
end)

vim.keymap.set('n', '<leader>i', function ()
    vim.api.nvim_feedkeys("<C-n>", 'n', false)
    vim.defer_fn(function() vim.cmd("call feedkeys(\"i1<CR>\")") end, 1000)
    vim.lsp.buf.code_action()
    -- vim.api.nvim_feedkeys("1<CR>", 'n', false)
end)
--- Autocomplete bracket pair
vim.keymap.set('i', '<CR>', function()
    local line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local next_line = { false } -- vim.api.nvim_buf_get_lines(0, row, row + 1, false)
    -- print(next_line[1])
    local currentChar = line:sub(col, col);
    if col < #line and (
        (currentChar == '{' and line:sub(col + 1, col + 1) == '}') or
        (currentChar == '[' and line:sub(col + 1, col + 1) == ']') or
        (currentChar == '(' and line:sub(col + 1, col + 1) == ')') or
        (currentChar == '>' and line:sub(col + 1, col + 1) == '<')
    ) then
        return '<CR><CR>kV"_C'
    end

    if col == #line then
        if currentChar == '{' and (not next_line[1] or not next_line[1]:match('^%s*}')) then
            return '<CR><CR>}kV"_C'
        end
        if currentChar == '[' and (not next_line[1] or not next_line[1]:match('^%s*]')) then
            return '<CR><CR>]kV"_C'
        end
        if currentChar == '(' and (not next_line[1] or not next_line[1]:match('^%s*)')) then
            return '<CR><CR>)kV"_C'
        end
    end
    -- print(line:sub(col, 1), line:sub(col + 1, 1))
    -- return line:sub(col, 1) .. line:sub(col + 1, 1) 
    -- print("It is " .. line:sub(col, col) .. line:sub(col + 1, col + 1) .. #line .. col)
    return '<CR>'
end, { expr = true });

local generalSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })
-- vim.api.nvim_create_autocmd("TextYankPost", {
--     group = generalSettingsGroup,
--     callback = function()
--         vim.highlight.on_yank()
--     end
-- })

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*.api' },
    callback = function()
        print('execing')
        vim.keymap.set('x', '<CR>', curl, { expr = true })
    end,
    group = generalSettingsGroup,
})

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
