local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local fb_actions = require "telescope".extensions.file_browser.actions

local custom_actions = {}

--- multi-select enabled cleverness
-- similar to fzf.
-- Adapted from https://github.com/nvim-telescope/telescope.nvim/issues/416#issuecomment-841273053
-- Possible entry-point to learning lua and contrib?
-- Adapted to do cwd on filebrowser
function custom_actions.fzf_multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #(picker:get_multi_selection())

  if num_selections > 1 then
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist(prompt_bufnr)
  else
    actions.select_default(prompt_bufnr)
  end
end

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = ' ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.75,
      preview_cutoff = 120,
      prompt_position = 'bottom',
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
        height = 1,
      },
    },
    file_sorter = require 'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {
    },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {
        ['<C-q>'] = actions.send_to_qflist,
        ['<tab>'] = actions.toggle_selection,
        ['<s-tab>'] = actions.toggle_selection,
        ['<cr>'] = custom_actions.fzf_multi_select
      },
      n = {
        ['<C-q>'] = actions.send_to_qflist,
        ['<tab>'] = actions.toggle_selection,
        ['<s-tab>'] = actions.toggle_selection,
        ['<cr>'] = custom_actions.fzf_multi_select
      },
    }
  },
  extensions = {
    file_browser = {
      mappings = {
        i = {
          ['<C-r>'] = fb_actions.rename,
          ['<C-y>'] = fb_actions.copy,
          ['<C-m>'] = fb_actions.move,
          ['<C-d>'] = fb_actions.remove,
          ['<C-n>'] = fb_actions.create_from_prompt,
        },
      }
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
