#!/bin/sh -l

set -eu

NAMESPACE=$1
APP=$2
SOURCE_DIR=$3
DEST_DIR=$4
KUBECONFIG=$5

echo $HOME
ls -la
export KUBECONFIG=$KUBECONFIG/.kube/config

POD_NAME=$(kubectl get pods -n ${NAMESPACE} -l app=${APP} | grep -v NAME | cut -d' ' -f1 | head -n 1)
krsync -av --progress --stats ${SOURCE_DIR} ${POD_NAME}@${NAMESPACE}:${DEST_DIR}
