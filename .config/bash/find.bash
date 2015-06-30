# find file names
function ff() { find . -type d \( -name CVS \) -prune -o -type f \( -name \*$1\* \); }

# f <extension> <grep pattern>
function f() { find . -type d \( -name CVS \) -prune -o \( -name \*.$1 \) -print0 | xargs -0 grep -n --color=auto $2; }
# fin <extension> <grep pattern>
# case insensitive
function fin() { find . -type d \( -name CVS \) -prune -o \( -name \*.$1 \) -print0 | xargs -0 grep -in --color=auto $2; }
# fl <extension> <grep pattern>
# list files containing exact match
function fl() { find . -type d \( -name CVS \) -prune -o \( -name \*.$1 \) -print0 | xargs -0 grep -l --color=auto $2; }

# list files with match on firstline
function firstline() { find . -type f | xargs egrep -H -m 1 -n "$1" | awk -F : '$2 <= 1 {print $1;}'; }
function allcontaining() { find . -type f -print0 | xargs -0 grep -li $*; }
