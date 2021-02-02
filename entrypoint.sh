#!/bin/sh -l

set -eu

CLUSTER=$1
NAMESPACE=$2
APP=$3
SOURCE_DIR=$4
DEST_DIR=$5
KUBECONFIG=$6

export KUBECONFIG=${KUBECONFIG}/.kube/config
env
aws eks update-kubeconfig --name ${CLUSTER} --region ${AWS_DEFAULT_REGION}
POD_NAME=$(kubectl get pods -n ${NAMESPACE} -l app=${APP} | grep -v NAME | cut -d' ' -f1 | head -n 1)

ls -la /usr/local/bin/krsync
ls -la /usr/local/bin/kubectl
krsync -av --progress --stats ${SOURCE_DIR} ${POD_NAME}@${NAMESPACE}:${DEST_DIR}
