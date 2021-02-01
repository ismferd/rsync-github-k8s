#!/bin/sh -l

set -eu

export KUBECONFIG=$KUBECONFIG/.kube/config
echo $NAMESPACE
echo $APP
echo $SOURCE_DIR
echo $DEST_DIR

POD_NAME=$(kubectl get pods -n ${NAMESPACE} -l app=${APP} | grep -v NAME | cut -d' ' -f1 | head -n 1)
/usr/local/bin/krsync -av --progress --stats ${SOURCE_DIR} ${POD_NAME}@${NAMESPACE}:${DEST_DIR}
