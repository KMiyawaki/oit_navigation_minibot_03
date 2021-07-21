#!/bin/bash

function main() {
    local -r PKG="zed_display_rviz"
    local -r LAUNCH="display_zed2.launch"
    local -r PARAM_NAME="svo_file"
    local -r MIN_ARG=1
    if [ $# -lt "${MIN_ARG}" ]; then
        echo "${FUNCNAME[0]} 引数は ${MIN_ARG} 個以上必要です。" 1>&2
        echo "usage: ${FUNCNAME[0]} [bag filename]" 1>&2
        return 1
    fi
    
    local -r SVO_FILE=$(cd $(dirname ${1}); pwd)/$(basename ${1})
    echo ${SVO_FILE}
    local -r ADDITIONAL="${2}"
    local -r CMD="roslaunch ${PKG} ${LAUNCH} ${PARAM_NAME}:=${SVO_FILE} ${ADDITIONAL}"
    # echo ${CMD}
    eval ${CMD}
}

main "$@"
