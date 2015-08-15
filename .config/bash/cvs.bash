# -------------------------
# cvs aliases and functions
# -------------------------
function cedit { cvs edit "$@" ; gvim "$@"; };
function cdiff { cvs diff -wbBud "$@"; };
function cunedit { cvs unedit "$@"; };
function cupd { cvs -q update -Pd; };
function cstat() { cvs -Q status "$@" | grep "Status:" | grep -v "Up-to-date"; };
