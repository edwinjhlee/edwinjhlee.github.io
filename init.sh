#! /usr/bin/env bash

# source <(curl https://edwinjhlee.github.io/el-logic/init.sh)

# source <(curl https://edwinjhlee.github.io/el-logic/lib/chalk.sh)

install_me(){
    local path=$(gen_lib_path init.sh)
    curl https://edwinjhlee.github.io/el-logic/init.sh > $path
    local code="source $path"
    grep -q "$code" "$HOME/.bashrc" || echo "source $path" >> $HOME/.bashrc
}

update_me(){
    local path=$(gen_lib_path init.sh)
    curl https://edwinjhlee.github.io/el-logic/init.sh > $path
    source $path
}

gen_lib_path(){
    local local_lib_root=/tmp/libs
    mkdir -p "$local_lib_root"
    echo "$local_lib_root/$1"
}

include_lib_from_cache_or_web(){
    local lib=${1:?"Please provide library name"}
    local url=${2:?"Please provice url"}
    local local_lib_path=$(gen_lib_path $lib)
    
    if [ ! -f $local_lib_path ]; then
        curl $url >$local_lib_path
    fi
    source $local_lib_path
    # source <([ -e $local_lib_path ] && cat $local_lib_path || curl $url >$local_lib_path)
}

include_ellib_from_cache_or_web(){
    local lib=${1:?"Please provide library name"}
    include_lib_from_cache_or_web $lib https://edwinjhlee.github.io/el-logic/lib/$lib
}

include_ellib_from_cache_or_web_all(){
    for i in $*; do include_ellib_from_cache_or_web $i; done
}

MINIMUM=(
    chalk.sh
)

STANDARD=(
    ${MINIMUM[@]}
    apps.sh
)

DY=(
    ${STANDARD[@]}
    dy.sh
)

DG=(
    ${STANDARD[@]}
    dg.sh
)

include_pack(){
    case "$1" in
        "min") include_ellib_from_cache_or_web_all ${MINIMUM[*]} ;;
        "sta") include_ellib_from_cache_or_web_all ${STANDARD[*]} ;;
        "dy" ) include_ellib_from_cache_or_web_all ${DY[*]} ;;
        "dg" ) include_ellib_from_cache_or_web_all ${DG[*]} ;;
        *) ;;
    esac
}

include_pack $1
