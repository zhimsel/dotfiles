local map = require('zhimsel.util').map

return {
  {
    -- https://github.com/zbirenbaum/copilot.lua
    'zbirenbaum/copilot.lua',
    dependencies = {
      {
        'zbirenbaum/copilot-cmp',
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
  }
}
