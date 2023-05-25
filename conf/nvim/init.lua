-- basic config
require "mvim.options"
require "mvim.keymaps"
require "mvim.plugins"
require "mvim.colorscheme"
require "mvim.autocommands"
-- plugins config start
require "mvim.cmp"
require "mvim.lsp"
-- plugins config end
require("mvim.bootstrap"):init()




