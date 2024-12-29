
return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim", build = ":MasonUpdate" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            -- Initialize lsp-zero
            local lsp = require("lsp-zero").preset({
                name = "recommended",
                manage_nvim_cmp = true,
                set_lsp_keymaps = true,
            })

            -- Ensure autocompletion is properly set up
            lsp.setup_nvim_cmp({
                mapping = lsp.defaults.cmp_mappings(),
            })

            -- Ensure core LSP servers are installed
            lsp.ensure_installed({
                "pyright", -- Python
                "tsserver", -- JavaScript/TypeScript
                "lua_ls", -- Lua
            })

            -- Configure Lua server for Neovim development
            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

            -- Apply lsp-zero configuration
            lsp.setup()
        end,
    },
    {
        "dundalek/lazy-lsp.nvim",
        dependencies = { "VonHeikemen/lsp-zero.nvim" },
        config = function()
            require("lazy-lsp.nvim").setup({
                -- Automatically manage LSP servers
                servers = {
                    rust_analyzer = {
                        settings = {
                            ["rust-analyzer"] = {
                                checkOnSave = { command = "clippy" },
                            },
                        },
                    },
                    typst_lsp = {
                        settings = {
                            exportPdf = "onSave", -- Automatically export PDF
                        },
                    },
                },
            })
        end,
    },
    -- Additional plugins (e.g., Treesitter, Telescope) can be added here
}
