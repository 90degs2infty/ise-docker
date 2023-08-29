#!/bin/bash
LICENSE_PATH=$1

podman run \
    -it \
    --rm \
    --net=bridge \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $LICENSE_PATH:/root/.Xilinx/Xilinx.lic:ro \
    xilinx-ise
    # -v $HOME/.Xauthority:/root/.Xauthority:ro \
