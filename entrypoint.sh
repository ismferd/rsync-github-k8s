#!/bin/sh -l

set -eu

echo $1
echo ${NAMESPACE}
echo ${APP}

export KUBECONFIG=${KUBECONFIG}/.kube/config


POD_NAME=$(kubectl get pods -n ${NAMESPACE} -l app=${APP} | grep -v NAME | cut -d' ' -f1 | head -n 1)
/usr/local/bin/krsync -av --progress --stats ${SOURCE_DIR} ${POD_NAME}@${NAMESPACE}:${DEST_DIR}
