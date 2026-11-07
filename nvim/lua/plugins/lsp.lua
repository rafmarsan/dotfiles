return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- Aquí le dices a Mason que te asegure estos servidores en Fedora o Mac
        ensure_installed = { 
          "lua_ls", 
          "basedpyright", 
          "gopls", 
          "yamlls", 
          "ansiblels" 
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,

    keys = {
      { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
      { "gr", vim.lsp.buf.references, desc = "Find references" },
      { "<leader>rn", vim.lsp.buf.rename, desc = "Rename symbol" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code actions" },
      { "<leader>d", vim.diagnostic.open_float, desc = "Line diagnostics" },
    },

    config = function()
      vim.lsp.config("ansiblels", {
        settings = {
          ansible = {
            validation = {
              enabled = true,
              lint = {
                enabled = false,
              },
            },
          },
        },
        filetypes = { "ansible", "yaml.ansible" },
      })

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("gopls")
      vim.lsp.enable("yamlls")
      vim.lsp.enable("ansiblels")
    end,
  },
}
