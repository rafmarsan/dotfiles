-- Mover líneas en Modo Normal
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { desc = 'Mover línea abajo' })
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { desc = 'Mover línea arriba' })

-- Mover bloques en Modo Visual
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = 'Mover bloque abajo' })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = 'Mover bloque arriba' })

