local M = {}

-- Convenience function for creating key maps (with defaults)
function M.map(mode, lhs, rhs, opts)
    local options = {
      noremap = true,
      silent = true,
    }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

return M
