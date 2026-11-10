case "$(uname -s)" in
    Darwin)
        alias ls='ls -G'
        ;;
    Linux)
        alias ls='ls --color=auto'
        ;;
esac

alias pip=pip3
alias py=python3
alias t=terraform
alias gor='cd ~/Repos'
alias god='cd ~/Downloads'
alias godot='/Applications/Godot.app/Contents/MacOS/Godot'

k() {
  if [ "$1" = "krew" ]; then
    local plugin=$1
    shift
    kubectl $plugin "$@"
  else
    kubectl --insecure-skip-tls-verify "$@"
  fi
}
