# .zshrc

source ~/.aliases.zsh

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

WORDCHARS=${WORDCHARS//\/}

bindkey "^[b" backward-word
bindkey "^[f" forward-word

eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Redirigir el caracter especial al cd en cascada de fzf
if [ -n "$functions[fzf-cd-widget]" ]; then
  bindkey '©' fzf-cd-widget
fi
