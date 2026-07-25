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
alias k='kubectl --insecure-skip-tls-verify'
alias t=terraform
alias mrw='. ~/Documents/DevOps/Python/rewards/bin/activate; py ~/Documents/DevOps/Python/rewards/rewards.py'
alias gor='cd ~/Repos'
alias god='cd ~/Downloads'
alias godot='/Applications/Godot.app/Contents/MacOS/Godot'
