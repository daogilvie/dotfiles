-- Some important things that have to be set first
local g = vim.g

-- Setting the leaders early to avoid any bad remaps.
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Packer-powered plugins
require('plugins')
