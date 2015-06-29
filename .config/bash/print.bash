# --------
# printing
# --------
function printcode() { enscript -2krGE -H3 -fCourier6 --line-numbers $*; }
function printcode1() { enscript --color -2krGE -H3 -fCourier6 --line-numbers $*; }
function printcode2() { enscript --tabsize 4 --color -1krE -H3 -fCourier8 --header='$n|%W|Page $%' --line-numbers -c -U2 --nup-xpad=0 --margins=15:15:10:10 $*; }
function printfile() { enscript --color -1krGE -H3 -fCourier6 --line-numbers -p $1.ps $1; }
function printpdf() { enscript --color -2krGE -H3 -fCourier6 --line-numbers -p $1.ps $1 ; ps2pdf $1.ps; \rm $1.ps; }
function printpdf2() { enscript --tabsize 4 --color -1krE -H3 -fCourier8 --header='$n|%W|Page $%' --line-numbers -c -U2 --nup-xpad=0 --margins=15:15:10:10 -p $1.ps $1 ; ps2pdf $1.ps ; \rm $1.ps; }
