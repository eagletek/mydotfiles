function vim-install {
    local orig_dir="$(pwd)"
    local plugin="$1"
    cd ~/.vim/bundle
    [[ ! -h "$plugin" ]] && ln -s "$HOME/vim-plugins/${plugin}"
    cd "$orig_dir"
}

function vim-uninstall {
    local orig_dir="$(pwd)"
    local plugin="$1"
    cd ~/.vim/bundle
    [[ -h "$plugin" ]] && unlink "$plugin"
    cd "$orig_dir"
}

_vim_install()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$(\ls ~/vim-plugins)" -- $cur) )
        return
    fi
}
complete -o bashdefault -o default -o nospace -F _vim_install vim-install

_vim_uninstall()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$(\ls ~/.vim/bundle)" -- $cur) )
        return
    fi
}
complete -o bashdefault -o default -o nospace -F _vim_uninstall vim-uninstall
