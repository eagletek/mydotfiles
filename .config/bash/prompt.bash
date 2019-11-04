function git_branch()
{
    GIT_BRANCH=""
    export GIT_BRANCH
    GIT_REPO=""
    export GIT_REPO

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

    GIT_REPO_DIR="$(git rev-parse --show-toplevel)"
    GIT_REPO=$(basename "${GIT_REPO_DIR}")
    export GIT_REPO_DIR
    export GIT_REPO
}

function virtual_environment_info()
{
    # disable default virtualenv prompt
    export VIRTUAL_ENV_DISABLE_PROMPT=0

    VIRTUAL_ENV_NAME=""
    if [[ -n "${VIRTUAL_ENV}" ]]; then
        VIRTUAL_ENV_NAME="$(basename "${VIRTUAL_ENV}")"
    fi
    export VIRTUAL_ENV_NAME
}

function bash_prompt_command()
{
    git_branch
    virtual_environment_info

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

    GIT_PWD=""
    [[ -n "${GIT_BRANCH}" ]] && GIT_PWD="${PWD/${GIT_REPO_DIR}/▸}"
    export GIT_PWD
}

PROMPT_COMMAND=bash_prompt_command

function get_os_info() {
  export KERNEL_VERSION="$(uname -r)"

  export OS_DISTRIB_NAME="UNK"
  export OS_DISTRIB_RELEASE="0.0"
  
  if which lsb_release > /dev/null; then
    export OS_DISTRIB_NAME="$(lsb_release -is)"
    export OS_DISTRIB_RELEASE="$(lsb_release -rs)"
  fi

  if [[ "${OS_DISTRIB_NAME}" == "RedHatEnterprise" ]]; then
    export OS_DISTRIB_NAME="RHEL"
  fi
}
get_os_info

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
# U+E235    nf-fae-python


# --- Powerline prompt nodes --- #
# mkcolor uses Base-6 RGB colors

# blue/green/grey
#ps1_fg=($(mkgray 20)     $(mkgray 5)      $(mkcolor 1 3 0))
#ps1_bg=($(mkcolor 1 1 5) $(mkcolor 1 3 0) $(mkgray 5))

# burgundy/orange/grey (VT)
#ps1_fg=($(mkgray 23)     $(mkcolor 1 0 0) $(mkcolor 5 2 0))
#ps1_bg=($(mkcolor 1 0 0) $(mkcolor 5 2 0) $(mkgray 5))

# red/white/gray
#ps1_fg=($(mkgray 23)     $(mkcolor 1 0 0) $(mkgray 23))
#ps1_bg=($(mkcolor 1 0 0) $(mkgray 23) $(mkgray 5))

# orange/gray
ps1_fg=(166 208 15)
ps1_bg=($(mkgray 3) $(mkgray 5) $(mkgray 7))

# red/gray/green
#ps1_fg=($(mkcolor 5 0 0) $(mkcolor 0 5 0) $(mkgray 0))
#ps1_bg=($(mkgray 1) $(mkgray 10) $(mkgray 18))

mknode() {
    node=$1
    content=$2
    next=$((node+1))
    nextbg="$([[ ! -z "${ps1_bg[${next}]}" ]] && mkbg ${ps1_bg[${next}]} || bgreset)"
    echo "\[$(mkbg ${ps1_bg[$node]})$(mkfg ${ps1_fg[$node]})\]${content}\[${nextbg}$(mkfg ${ps1_bg[$node]})\]"
}
node0="$(mknode 0 '\u@\h  ${OS_DISTRIB_NAME} ${OS_DISTRIB_RELEASE} ')"
node1="$(mknode 1 '$([[ -n ${GIT_BRANCH} ]] && echo "   ${GIT_REPO}  ${GIT_BRANCH} " || echo "")')"
node2="$(mknode 2 '$([[ -n ${GIT_BRANCH} ]] && echo " ${GIT_PWD} " || echo " ${NEW_PWD} ")')"
node3="$(mknode 0 '')"
node4="$(mknode 1 '$([[ -n ${VIRTUAL_ENV_NAME} ]] && echo "  ${VIRTUAL_ENV_NAME} " || echo "")')"
node5="$(mknode 2 '$(date "+%F %I:%M %p") ')"

case "${TERM}" in
    xterm*)
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
        export PS1="${TITLEBAR}${node0}${node1}${node2}\n${node3}${node4}${node5}\[$Color_Off\] "
        # blue/green/grey -- no powerline
        export PS1_NOPL="${TITLEBAR}\[\e[0;37;48;5;4m\]\u@\h\$([[ -n \${GIT_BRANCH} ]] && echo \"\[\e[0;38;5;234;48;5;2m\] \${GIT_BRANCH} \")\[\e[0;92;48;5;0m\]\${NEW_PWD}\[\e[0m\e[0;38;5;0m\]\[$Color_Off\] "
        ;;
    screen)
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
