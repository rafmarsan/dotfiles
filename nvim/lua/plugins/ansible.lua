return {
  {
    "pearofducks/ansible-vim",
    ft = { "yaml.ansible", "ansible" },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {},
      },
    },
  },
}
