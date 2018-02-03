# -----------
# Environment
# -----------
export EDITOR=vim

# Remove duplicates, preserving order
pathCleanup()
{
    export PATH="$(echo $PATH | perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, scalar <>))')"
}

# Add arguments to front of PATH, preserving argument order
pathPrepend()
{
    extras=""
    for dir in "$@"; do
        extras="${extras}${dir}:"
    done
    [[ -z "$extras" ]] || export PATH="${extras}${PATH}"
    pathCleanup
}

# Add arguments to end of PATH, preserving argument order
pathAppend()
{
    extras=""
    for dir in "$@"; do
        extras="${extras}:${dir}"
    done
    [[ -z "$extras" ]] || export PATH="${PATH}${extras}"
    pathCleanup
}

pathPrepend . ${HOME}/bin

if [[ -d ~/.rbenv ]]; then
    ln -fs ~/.rbenv/bin/rbenv ~/bin/rbenv
    pathPrepend ~/.rbenv/plugins/ruby-build/bin
    eval "$(rbenv init -)"
fi

if [[ -d /usr/local/go ]]; then
    pathPrepend /usr/local/go/bin
    export GOPATH="${HOME}/workspace/go"
    pathPrepend "${GOPATH}/bin"
fi
