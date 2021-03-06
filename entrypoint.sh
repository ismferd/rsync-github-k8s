#!/bin/sh -l

set -eu

CLUSTER=$1
NAMESPACE=$2
APP=$3
SOURCE_DIR=$4
DEST_DIR=$5

aws eks update-kubeconfig --name ${CLUSTER} --region ${AWS_DEFAULT_REGION}
POD_NAME=$(kubectl get pods -n ${NAMESPACE} -l app=${APP} | grep -v NAME | cut -d' ' -f1 | head -n 1)

krsync -av --progress --stats ${SOURCE_DIR} ${POD_NAME}@${NAMESPACE}:${DEST_DIR}
