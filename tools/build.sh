#/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

buildah bud -t xilinx-ise $SCRIPT_DIR/../context/
