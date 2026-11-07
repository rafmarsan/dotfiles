#!/usr/bin/env bash

SESSION="dev"

# Si ya existe, entrar
if tmux has-session -t "$SESSION" 2>/dev/null; then
    exec tmux attach -t "$SESSION"
fi

# Crear sesión
tmux new-session -d -s "$SESSION" -n dev

# Abrir Neovim
tmux send-keys -t "$SESSION":1 "nvim" C-m

# Crear shell inferior
tmux split-window -v -t "$SESSION":1

# La shell ocupa un 40%
tmux resize-pane -t "$SESSION":1.1 -y 40%

# Volver al pane de nvim
tmux select-pane -t "$SESSION":1.0

# Zoom por defecto
tmux resize-pane -Z -t "$SESSION":1.0

# Crear ventana OpenCode
tmux new-window -t "$SESSION" -n opencode "opencode"

# Volver a la ventana principal
tmux select-window -t "$SESSION":1

# Ahora sí, entrar
exec tmux attach -t "$SESSION"
