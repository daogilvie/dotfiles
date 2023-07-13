return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    -- Telescope is so fundamental that we always want it
    lazy = false,
    config = function()
      local map = require('utils').map_key
      local tele = require('telescope.builtin')
      local tele_file_browser = require 'telescope'.extensions.file_browser.file_browser
      local trouble = require("trouble.providers.telescope")
      local function tele_find_with_hidden()
        local opts = { hidden = true }
        return tele.find_files(opts)
      end

      map({ 'n' }, '<C-f>', tele.live_grep, 'Live Grep')
      map({ 'n' }, '<C-p>', tele_find_with_hidden, 'Find file (inc hidden)')
      map({ 'n' }, '<leader>o', tele_file_browser, 'File Browswer')
      map({ 'n' }, '<leader>O', function()
        tele_file_browser({ path = '%:p:h', cwd_to_path = true })
      end, 'File Browser open at buffer')
      map({ 'n' }, '<leader>se', tele.symbols, 'Search emoji')
      map({ 'n' }, '<leader>sp', tele.buffers, 'Search buffers')
      map({ 'n' }, '<leader>sw', function()
        tele.grep_string({ search = vim.fn.expand('<cword>') })
      end, 'Search CWord')
      map({ 'n' }, '<leader>sR', tele.lsp_dynamic_workspace_symbols, 'Workspace symbols')
      map({ 'n' }, '<leader>sr', tele.lsp_document_symbols, 'Document symbols')

      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local fb_actions = require "telescope".extensions.file_browser.actions

      local custom_actions = {}

      -- multi-select enabled cleverness
      -- similar to fzf.
      -- Adapted from https://github.com/nvim-telescope/telescope.nvim/issues/416#issuecomment-841273053
      -- Possible entry-point to learning lua and contrib?
      -- Adapted to do cwd on filebrowser
      function custom_actions.fzf_multi_select(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local num_selections = #(picker:get_multi_selection())

        if num_selections > 1 then
          trouble.open_selected_with_trouble(prompt_bufnr)
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
          set_env = { ['COLORTERM'] = 'truecolor' },           -- default = nil,
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
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim',   build = 'make', lazy = false },
  { 'nvim-telescope/telescope-file-browser.nvim', lazy = false },
  { 'nvim-telescope/telescope-symbols.nvim',      lazy = false },
}
