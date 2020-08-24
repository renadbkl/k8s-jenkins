#!/bin/bash
k3d cluster create jenkins -v /var/run/docker.sock:/var/run/docker.sock --agents 3 -p 30000-32767:30000-32767@server[0]
source <(k3d completion bash)
source <(kubectl completion bash)
kubectl apply -f jenkins.namespace.yaml
kubectl apply -f jenkins.helm.yaml
WAIT=60
echo "Sleeping for $WAIT"
sleep $WAIT
echo "Making progress"
. query.sh
