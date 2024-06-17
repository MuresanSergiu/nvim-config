require('plugins')

local set = vim.opt
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.autoindent = false
set.smartindent = false
set.cursorline = true
set.nu = true
set.relativenumber = true
set.wrap = false
-- set.guicursor = 'n-v-c-sm:block,i-ci-ve:ver40,r-cr-o:hor20'

set.hlsearch = true
set.incsearch = true

set.scrolloff = 8
set.updatetime = 50
set.colorcolumn = "160"
set.showtabline = 0

vim.g.mapleader = ' '
vim.g.db_ui_execute_on_save = false
vim.g.ftplugin_sql_omni_key = '<C-S>'
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

-- vim.keymap.set('n', '<M-Left>', '<C-o>');
-- vim.keymap.set('n', '<M-Right>', '<C-i>');

vim.keymap.set({'c'}, '<C-k>', '<Up>');
vim.keymap.set({'c'}, '<C-j>', '<Down>');

vim.keymap.set({'c', 'i', 'n', 'x'}, '<Left>', '<nop>');
vim.keymap.set({'c', 'i', 'n', 'x'}, '<Right>', '<nop>');
vim.keymap.set({'c', 'i', 'n', 'x'}, '<Up>', '<nop>');
vim.keymap.set({'c', 'i', 'n', 'x'}, '<Down>', '<nop>');

vim.keymap.set('n', '<leader>/', ':let @/ = ""<CR>');
vim.keymap.set('v', '<leader>sc', ':s/\\u/_\\l&/g<CR>:let @/ = ""<CR>');

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
vim.api.nvim_create_user_command('Build', '!rm extension.xpi; npx webpack && zip -r extension.xpi dist/ manifest.json && cp -f extension.xpi ~/Development/tor && cd collector/ && cargo run --bin scraper setup 8', {});
vim.api.nvim_create_user_command('W', 'w', {});
vim.api.nvim_create_user_command('DBS', 'tabnew | DBUI', {})
vim.api.nvim_del_user_command('EditQuery')
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

--- CURL utility
vim.keymap.set('x', '<leader>r', function()
    local vpos = vim.fn.getpos("v")
    -- local vstart = vim.fn.getpos("'<")
    local vstart = vpos[2]
    -- local vend = vim.fn.getpos("'>")
    local vend, _ = unpack(vim.api.nvim_win_get_cursor(0))
    if vend < vstart then
        vend, vstart = vstart, vend
    end
    local n_lines = math.abs(vend - vstart) + 1
    local lines = vim.api.nvim_buf_get_lines(0, vstart - 1, vend, false)

    -- HOST
    print(lines[1])
    local host = lines[1]:gsub("?", "\\?")

    local words = {}
    words[1], words[2] = host:match("(.+) (.+)")

    local method = "GET"
    if words[1] ~= nil then
        method = words[1]
        host = words[2]
    end

    print("The result:", words[1], words[2])

    -- HEADERS
    local headers = "-H \"Content-Type: application/json\"";

    local extra_commands = ''

    -- BODY
    local body = ""
    for i = 2, n_lines do
        lines[i] = lines[i]:gsub("^%s+", "")
        if lines[i]:sub(1, 1) == '-' then
            extra_commands = extra_commands .. ' ' .. lines[i]
        else
            body = body .. lines[i];
        end
    end
    body = "'" .. body .. "'"

    -- Command construction
    local curl = "! curl -D - -X " .. method .. ' ' .. headers .. ' ' .. extra_commands .. ' -s "' .. host .. '"'
    if #body > 0 then
        curl = curl .. " -d " .. body
    end
    print("Command curl is", curl)
    return curl .. "<CR>:lua vim.api.nvim_win_set_cursor(0, {vim.fn.search('{', 'n'), 0})<CR>V:!jq<CR>"
end, { expr = true })

vim.keymap.set('n', '<leader>m', ':messages<CR>')
vim.keymap.set('n', '<leader>cc', function()

end)


