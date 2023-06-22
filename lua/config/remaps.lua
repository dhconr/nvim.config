-- Moving 
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Inserting line 
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- Moving Lines in Visual mode 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP") 

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d") 
vim.keymap.set("v", "<leader>d", "\"_d") 

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Saving File
vim.keymap.set("n", "<C-s>", ":w<Enter>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<Enter>")

-- Neo Tree 
vim.keymap.set("n", "<C-f>", ":Neotree filesystem reveal left toggle<Enter>") 
vim.keymap.set("i", "<C-f>", "<Esc>:Neotree filesystem reveal left<Enter>") 

-- Toggle Term
vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal<Enter>")
vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<Enter>")
vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical size=60<Enter>")





