function notes() {
    gvim "/home/$USER/workspace/notes/${1}-$(date +%F).md"
}

_notes()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$(\ls ~/workspace/notes/ | sed -e "s/-[0-9]\+-[0-9]\+-[0-9]\+.md//")" -- $cur) )
        return
    fi
}
complete -o bashdefault -o default -o nospace -F _notes notes

function mdview() {
    Markdown.pl "${1}" | lynx -stdin
}
