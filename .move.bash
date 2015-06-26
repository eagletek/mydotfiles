# --------------------
# changing directories
# --------------------
function up () {
    dir=.
    if [ -z $1 ]; then
        cd ..
    elif [ $1 -gt 0 ]; then
        let count=0
        while [ $count -lt $1 ]; do
            dir=$dir/..
            let count=count+1
        done
    cd $dir
    else
        echo "Argument must be a positive integer."
    fi
}

function cds() {
    cd ~/staging/$*
}

function cdw() {
    cd ~/workspace/$*
}

function cdh() {
    cd ~/$*
}

function pd() {
  pushd $*
}

