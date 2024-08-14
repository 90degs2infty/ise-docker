#!/bin/bash

help() {
    echo
    echo "Run a containerized xilinx ISE command"
    echo
    echo "Syntax: ${0##*/} [-h] -l <license file> -p <project dir> -- <xilinx command>"
    echo
    echo "Options:"
    echo "-h                display this help message"
    echo "-l <license file> pass license file to the launched command"
    echo "-p <project dir>  mount the specified project directory for access inside the container"
    echo
    echo "                  The directory is mounted under '/workspace'. The specified directory"
    echo "                  has to be specified either as absolute path or with a leading './'"
    echo "                  (i.e. './foo/ instead of foo/)."
    echo
    echo "Positional commands:"
    echo "<xilinx command>  xilinx command to launch"
    echo
    echo "Example:"
    echo "${0##*/} -l ~/.Xilinx/Xilinx.lic -p . -- impact /workspace"
    echo
}

while getopts ":hl:p:-" option; do
    case $option in
        h) # print help
            help
            exit;;
        l) # license file
            LICENSE_PATH=$OPTARG;;
        p) # project directory
            PROJECT_DIR=$OPTARG;;
        -) # separator -- to split off everything that should go into the container
            break;;
        ?) # invalid option
            echo "Error: invalid option -${OPTARG}"
            exit 1;;
    esac
done

if [ -z "$LICENSE_PATH" ] || [ -z "$PROJECT_DIR" ]
then
    help
    exit 1
fi

if [ ! -f "$LICENSE_PATH" ]
then
    echo "license file '$LICENSE_PATH' does not exist"
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]
then
    echo "project directory '$PROJECT_DIR' does not exist"
    exit 1
fi

shift $((OPTIND - 1))

podman run \
    -it \
    --rm \
    --net=bridge \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $LICENSE_PATH:/root/.Xilinx/Xilinx.lic:ro \
    -v $PROJECT_DIR:/workspace \
    xilinx-ise \
    "$@"
