vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", ":NvimTreeFindFileToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>pg", ":NvimTreeFindFile<CR>", { silent = true })
vim.keymap.set("n", ";", ":")

-- use H/J/K/L in visual selection to move selected line(s)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "H", "<gv")
vim.keymap.set("v", "L", ">gv")
-- arrow keys move current line
vim.keymap.set("n", "<up>", "v:m '<-2<CR>gv=")
vim.keymap.set("n", "<down>", "v:m '>1<CR>gv=")
vim.keymap.set("n", "<right>", "v>")
vim.keymap.set("n", "<left>", "v<")

-- keep visual selection when changing indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- quote/paren/bracket/brace visual selection
vim.keymap.set("v", [[<leader>"]], [[<esc>`>a"<esc>`<i"<esc>]])
vim.keymap.set("v", "<leader>(", [[<esc>`>a)<esc>`<i(<esc>]])
vim.keymap.set("v", "<leader>[", [[<esc>`>a]<esc>`<i[<esc>]])
vim.keymap.set("v", "<leader>{", [[<esc>`>a}<esc>`<i{<esc>]])
vim.keymap.set("v", "<leader>{{", [[<esc>`<O{<esc>`>a<cr>}<esc>gv>]])

vim.keymap.set("n", "J", "mzJ`z") -- don't move cursor when Joining lines

-- Keep cursor centered on half-page scrolling and searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Don't replace clipboard content on paste / delete
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Copy/Paste with system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>p", [["+gp]])
vim.keymap.set("n", "<leader>P", [["+gP]])

-- Quickfix next/prev
--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search/Replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)
