-- 1. COMPORTAMIENTO VISUAL Y AGILIDAD
vim.opt.number = true          -- Muestra los números de línea a la izquierda
vim.opt.relativenumber = true  -- Números relativos (Indispensable para saber cuántas líneas saltar)
vim.opt.scrolloff = 8          -- Mantiene 8 líneas de margen visible arriba/abajo al scrollear
vim.opt.mouse = "a"            -- Habilita soporte de ratón (por si quieres hacer doble clic para seleccionar)

-- 2. IDENTACIÓN COMPATIBLE DE FÁBRICA (YAML, JSON, TOML, SH)
vim.opt.tabstop = 2            -- Una tabulación visual equivale a 2 espacios
vim.opt.shiftwidth = 2         -- Tamaño de la identación automática
vim.opt.expandtab = true       -- Transforma los Tabs automáticamente en espacios reales
