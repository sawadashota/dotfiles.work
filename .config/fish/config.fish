set -x EDITOR hx
set -x LANG en_US.UTF-8

set -x PATH /opt/homebrew/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH /opt/homebrew/opt/postgresql@15/bin $PATH

set -x DOCKER_HOST unix://$HOME/.colima/default/docker.sock

mise activate fish | source

# alias
alias brews 'brew search'
alias g git
alias d docker
alias dc 'docker compose'

alias av 'aws-vault'
alias ave 'aws-vault exec'
alias avl 'aws-vault login'

function gclean
    git fetch -p
    set -l gone_branches (git branch -vv | grep ': gone]' | awk '{print $1}')

    if test (count $gone_branches) -eq 0
        echo "No gone branches to clean"
        return
    end

    echo "Deleting branches:"
    printf '%s\n' $gone_branches

    for branch in $gone_branches
        git branch -D $branch
    end
end

function dkclean
    set -l containers (docker container ls -aq)

    if test (count $containers) -eq 0
        echo "No containers to remove"
        return
    end

    echo "Removing containers:"
    printf '%s\n' $containers
    docker container rm $containers
end

function dkclean-all
    docker container stop (docker container ls -q)
    docker container rm (docker container ls -aq)
end

function dkprune
    docker container prune -f
    docker image prune -f
    docker volume prune -f
end

# ghq + peco (^G)
function peco-ghq
    set -l selected_dir (ghq list | peco --query "$commandline")
    if test -n "$selected_dir"
        cd (ghq root)/$selected_dir
        commandline -f repaint
    end
end
bind \cg peco-ghq

# Search history (^H)
function peco-history-selection
    set -l selected (history | peco)
    if test -n "$selected"
        commandline -r $selected
        commandline -f repaint
    end
end
bind \ch peco-history-selection
