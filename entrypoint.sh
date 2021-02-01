#!/bin/sh -l

set -eu

NAMESPACE=$1
APP=$2
DIR=$3

POD_NAME=$(kubectl get pods -n ${NAMESPACE} -l app=${APP} | grep -v NAME | cut -d' ' -f1 | head -n 1)
./krsync -av --progress --stats .git/* ${POD_NAME}@${NAMESPACE}:${DIR}
