# ---------------
# general aliases
# ---------------
alias hist="history"
alias ssh="ssh -X"
alias ls='ls --color'
alias l='ls -hl'
alias ll='ls -hal'
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias gui='nautilus --browser .'
alias valgrind='valgrind --track-origins=yes --leak-check=full'
alias coreusage='mpstat -P ALL 1'

export MAKE_JOBS=6
alias mi="make -j${MAKE_JOBS} install"
alias mc="make -j${MAKE_JOBS} clean"

function sizeof() {
    du -hs "$@"
}

function bak() {
    cp "${1}" "${1}.bak"
}

function dateScript() {
    script "${1}"_$(date "+%Y-%b%d-%R").txt
}

function search() {
    firefox -search "$@"
}
