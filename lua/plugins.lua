local status, packer = pcall(require, "packer")
if (not status) then
    print("Packer is not installed")
    return
end


vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function (use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        -- or                            , branch = '0.1.x',
        requires = {
            {'nvim-lua/plenary.nvim'},
        }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    use ({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    })
    use 'nvim-treesitter/nvim-treesitter-context'
    -- use ({
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    --     after = "nvim-treesitter",
    --     requires = "nvim-treesitter/nvim-treesitter",
    -- })
    -- use "nvim-treesitter/nvim-treesitter-angular"
    use('tpope/vim-fugitive')
    use ({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    })
    use 'ThePrimeagen/vim-be-good'
    use 'numToStr/Comment.nvim'
    use ({ 'folke/trouble.nvim', requires = { 'nvim-tree/nvim-web-devicons' } })
    use 'mfussenegger/nvim-dap'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use 'kikito/inspect.lua'
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-abolish'
    use 'tpope/vim-dadbod'
    -- use 'kristijanhusak/vim-dadbod-completion'
    use 'kristijanhusak/vim-dadbod-ui'

    -- Random themes if needed
    use 'navarasu/onedark.nvim'
    use 'echasnovski/mini.ai'
    -- use({ 'rose-pine/neovim', as = 'rose-pine' })
    -- use 'tomasiser/vim-code-dark'
    -- use 'dunstontc/vim-vscode-theme'
    -- use 'martinsione/darkplus.nvim'
    -- use {"rockyzhang24/arctic.nvim", requires = {"rktjmp/lush.nvim"}, branch = "v2"}
end)
