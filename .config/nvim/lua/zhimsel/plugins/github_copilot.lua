local map = require('zhimsel.util').map

return {
  {
    -- https://github.com/zbirenbaum/copilot.lua
    'zbirenbaum/copilot.lua',
    dependencies = {
      {
        -- Revert when https://github.com/zbirenbaum/copilot-cmp/pull/116 is merged
        'xlucn/copilot-cmp', commit = 'bc153996a7b76fbaa7307356ab99e85e0924b6f7',
        -- 'zbirenbaum/copilot-cmp',
        dependencies = {
          { 'hrsh7th/nvim-cmp' },
        },
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require("copilot").setup({
        -- Use copilot-cmp instead
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  {
    -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    event = "VeryLazy",
    opts = { },
  },
}
