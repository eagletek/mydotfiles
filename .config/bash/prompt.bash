function git_branch()
{
    GIT_BRANCH=""
    export GIT_BRANCH

    local repo_info rev_parse_exit_code
    repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
        --is-bare-repository --is-inside-work-tree \
        --short HEAD 2>/dev/null)"
    rev_parse_exit_code="$?"

    if [ -z "$repo_info" ]; then
        return
    fi

    local short_sha
    if [ "$rev_parse_exit_code" = "0" ]; then
        short_sha="${repo_info##*$'\n'}"
        repo_info="${repo_info%$'\n'*}"
    fi
    local inside_worktree="${repo_info##*$'\n'}"
    repo_info="${repo_info%$'\n'*}"
    local bare_repo="${repo_info##*$'\n'}"
    repo_info="${repo_info%$'\n'*}"
    local inside_gitdir="${repo_info##*$'\n'}"
    local g="${repo_info%$'\n'*}"


    local r=""
    local b=""
    if [ -d "$g/rebase-merge" ]; then
        read b 2>/dev/null <"$g/rebase-merge/head-name"
    else
        if [ -n "$b" ]; then
            :
        elif [ -h "$g/HEAD" ]; then
            # symlink symbolic ref
            b="$(git symbolic-ref HEAD 2>/dev/null)"
        else
            local head=""
            if ! read head 2>/dev/null <"$g/HEAD"; then
                return
            fi
            # is it a symbolic ref?
            b="${head#ref: }"
            if [ "$head" = "$b" ]; then
                detached=yes
                b="$(git describe --contains --all HEAD)"
            fi
        fi
    fi

    GIT_BRANCH="${b##refs/heads/}"
    export GIT_BRANCH
}

function bash_prompt_command()
{
    #Also in .git-prompt.sh

    # How many characters of the $PWD should be kept
    local pwdmaxlen=35
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
    NEW_PWD="${NEW_PWD}"
    export NEW_PWD

    git_branch
}

PROMPT_COMMAND=bash_prompt_command

#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWCOLORHINTS=1
#PROMPT_COMMAND='__git_ps1 "[\[[01;34\]m\u@\h\[[0m\]" "]\\\$ "'

# Color chart @ http://wiki.archlinux.org/index.php/Color_Bash_Prompt
# also see https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#
# Powerline font characters:
# U+E0A0		Version control branch
# U+E0A1		LN (line) symbol
# U+E0A2		Closed padlock
# U+E0B0		Rightwards black arrowhead
# U+E0B1		Rightwards arrowhead
# U+E0B2		Leftwards black arrowhead
# U+E0B3		Leftwards arrowhead


# --- Powerline prompt nodes --- #
# mkcolor uses Base-6 RGB colors

# blue/green/grey
#ps1_fg=($(mkgray 20)     $(mkgray 5)      $(mkcolor 1 3 0))
#ps1_bg=($(mkcolor 1 1 5) $(mkcolor 1 3 0) $(mkgray 5))

# burgundy/orange/grey (VT)
ps1_fg=($(mkgray 23)     $(mkcolor 1 0 0) $(mkcolor 5 2 0))
ps1_bg=($(mkcolor 1 0 0) $(mkcolor 5 2 0) $(mkgray 5))

mknode() {
    node=$1
    content=$2
    next=$((node+1))
    nextbg="$([[ ! -z "${ps1_bg[${next}]}" ]] && mkbg ${ps1_bg[${next}]} || bgreset)"
    echo "\[$(mkbg ${ps1_bg[$node]})$(mkfg ${ps1_fg[$node]})\]${content}\[${nextbg}$(mkfg ${ps1_bg[$node]})\]"
}
node0="$(mknode 0 '\u@\h')"
node1="$(mknode 1 '$([[ -n ${GIT_BRANCH} ]] && echo "${GIT_BRANCH}" || echo "")')"
node2="$(mknode 2 '${NEW_PWD}')"

case "${TERM}" in
    "xterm")
        TITLEBAR='\[\033]0;\u@\h: ${NEW_PWD}\007\]'
        # two lines with 'nodes'
        #export PS1="${TITLEBAR}\[\e[01;37m\]\342\224\214(\[\e[0;94m\]\u@\h\[\e[01;37m\])\$([[ -n \${GIT_BRANCH} ]] && echo \"\342\224\200(\[\e[0;96m\]\${GIT_BRANCH_SYM}\[\e[01;96m\]\${GIT_BRANCH}\[\e[01;37m\])\")\n\342\224\224\342\224\200(\[\e[01;92m\]\${NEW_PWD}\[\e[01;37m\])\342\224\200>\[\e[0m\] "

        # one line with 'nodes'
        #export PS1="${TITLEBAR}\[$BWhite\]>\342\224\200(\[$IBlue\]\u@\h\[$BWhite\])\$([[ -n \${GIT_BRANCH} ]] && echo \"\342\224\200(\[$ICyan\]\${GIT_BRANCH_SYM}\[$BICyan\]\${GIT_BRANCH}\[$BWhite\])\")\342\224\200(\[$BIGreen\]\${NEW_PWD}\[$BWhite\])\342\224\200>\[$Color_Off\] "
        # non-unicode
        #export PS1="${TITLEBAR}\[$BWhite\]>-(\[$IBlue\]\u@\h\[$BWhite\])\$([[ -n \${GIT_BRANCH} ]] && echo \"-(\[$ICyan\]\${GIT_BRANCH_SYM}\[$BICyan\]\${GIT_BRANCH}\[$BWhite\])\")-(\[$BIGreen\]\${NEW_PWD}\[$BWhite\])->\[$Color_Off\] "

        # one line with powerline font 'nodes'
        # yellow/orange/burgundy
        #export PS1="${TITLEBAR}\[\e[0;30;48;5;220m\]\u@\h\[\e[0;38;5;220;48;5;202m\]\$([[ -n \${GIT_BRANCH} ]] && echo \"\[\e[0;30;48;5;202m\]\${GIT_BRANCH}\")\[\e[0;38;5;202;48;5;52m\]\[\e[0;97;48;5;52m\]\${NEW_PWD}\[\e[0m\e[0;38;5;52m\]\[$Color_Off\] "
        # blue/green/grey
        #export PS1="${TITLEBAR}\[\e[0;37;48;5;4m\]\u@\h\[\e[0;38;5;4;48;5;2m\]\$([[ -n \${GIT_BRANCH} ]] && echo \"\[\e[0;38;5;234;48;5;2m\]\${GIT_BRANCH}\")\[\e[0;38;5;2;48;5;0m\]\[\e[0;92;48;5;0m\]\${NEW_PWD}\[\e[0m\e[0;38;5;0m\]\[$Color_Off\] "
        export PS1="${TITLEBAR}${node0}${node1}${node2}\[$Color_Off\] "
        # blue/green/grey -- no powerline
        export PS1_NOPL="${TITLEBAR}\[\e[0;37;48;5;4m\]\u@\h\$([[ -n \${GIT_BRANCH} ]] && echo \"\[\e[0;38;5;234;48;5;2m\] \${GIT_BRANCH} \")\[\e[0;92;48;5;0m\]\${NEW_PWD}\[\e[0m\e[0;38;5;0m\]\[$Color_Off\] "
        ;;
    "screen")
        TITLEBAR='\[\033k\u@\h > ${NEW_PWD}\033\\\]'
        ESC='\[\ek\e\\\]'
        export PS1="[\[\e[01;34m\]\u@\h \${NEW_PWD}\[\e[0m\]]\$ "
        ;;
    *)
        export PS1='[\[\e[01;34m\]\u@\h \W\[\e[0m\]]\$ '
    ;;
esac


function nopl {
    export PS1="$PS1_NOPL"
}
