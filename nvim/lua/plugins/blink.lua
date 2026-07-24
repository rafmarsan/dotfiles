return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },

    opts = {
      keymap = {
        preset = "default",

        ["<C-Space>"] = {
          "show",
          "show_documentation",
          "hide_documentation",
        },

        ["<Tab>"] = {
          "accept",
          "fallback",
        },
      },

      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },
    },
  },
}
