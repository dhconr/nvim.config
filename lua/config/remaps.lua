-- Moving
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Moving lines in Visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"*p')

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Rename all instances of highlighted word 
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim.keymap.set('n', "<Char-0xAA>", ":30Lexplore<CR>", { desc = 'Open file explorer', silent = true })

-- Toggle Term
vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal size=05<Enter>')
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<Enter>')
vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical size=60<Enter>')

-- Moving between splits
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Moving between splits in terminal mode
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]])
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]])
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]])
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]])

-- Terminal mode keybinding to exit insert mode
vim.keymap.set('t', '<C-\\>', [[<C-\><C-n>]])
