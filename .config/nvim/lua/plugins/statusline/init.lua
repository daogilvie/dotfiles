local icons = require('config.icons')
local function code_location()
    local navic = require('nvim-navic')
    if navic.is_available() then
        local location = navic.get_location()
        local nice_location = ""
        if location ~= nil and location ~= "" then
            nice_location = "%#WinBarContext#" .. " " .. icons.ui.ChevronRight .. " " .. location .. "%*"
        end
        return nice_location
    else
        return ""
    end
end
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "meuter/lualine-so-fancy.nvim",
            "SmiteshP/nvim-navic",
        },
        event = "VeryLazy",
        opts = function()
            local components = require "plugins.statusline.components"
            return {
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = {},
                    section_separators = {},
                    disabled_filetypes = {
                        statusline = { "alpha", "lazy", "fugitive", "" },
                        winbar = {
                            "help",
                            "alpha",
                            "lazy",
                        },
                    },
                    always_divide_middle = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { { "fancy_mode", width = 3 } },
                    lualine_b = { components.git_repo, "branch" },
                    lualine_c = {
                        "filename",
                        { "fancy_cwd",        substitute_home = true },
                        components.diff,
                        { "fancy_diagnostics" },
                        components.separator,
                        components.lsp_client,
                    },
                    lualine_x = { components.spaces, "encoding", "fileformat", "filetype", "progress" },
                    lualine_y = {},
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = { "toggleterm", "quickfix" },
                winbar = {
                    lualine_a = { "filename", code_location },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_winbar = {
                    lualine_a = { "filename" },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
            }
        end,
    },
}
