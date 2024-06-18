--[[ Display ]]--
vim.opt.colorcolumn = "81"
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.cursorline = true
vim.opt.wrap = false -- disable long line wrapping
vim.opt.js = false -- no join spaces

--[[ Swap/Backup/Undo ]]--
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "undodir"
vim.opt.undofile = true

--[[ Visual characters ]]--
vim.opt.listchars.tab = "󰌒 "
vim.opt.listchars.trail = "·"
vim.opt.listchars.nbsp = "󱁐"
vim.opt.listchars.extends = ""
vim.opt.listchars.precedes = ""
vim.opt.list = true -- use listchars above

--[[ Indents ]]--
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smarttab = true

--[[ Code Indents ]]--
vim.opt.cindent = true
vim.opt.cino=":2,=2,g2,h2,u0,+1s"
-- :2 <- sets case indent under switch to 2 spaces
-- =2 <- sets code indent under case to 2 spaces
-- g2 <- sets c++ scope declaration indent to 2 spaces
-- h2 <- sets method / variables under scope declarations to 2 spaces
-- u0 <- sets indentation for extra unclosed parens to 0 spaces
-- +1s <- sets continuation lines to indent 1 'tabs'

--[[ Searching ]]--
vim.opt.ignorecase = true -- case-insensitive
vim.opt.smartcase = true
vim.opt.gdefault = true -- global replace by default

--[[ Folding ]]--
vim.opt.fdm = "syntax"
vim.opt.foldminlines = 2
vim.opt.foldcolumn = "auto:4"
