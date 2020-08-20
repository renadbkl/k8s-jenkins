#!/bin/bash
k3d cluster create mycluster --agents 3 -p 30000-32767:30000-32767@server[0]
source <(k3d completion bash)
source <(kubectl completion bash)
kubectl apply -f jenkins.namespace.yaml
kubectl apply -f jenkins.helm.yaml
sleep 30
POD=$(kubectl get pods -n jenkins -o json | jq '.items[1].metadata.name' | xargs)
echo "Jenkins credentials"
echo username: $(kubectl -n jenkins --container jenkins exec $POD -- env | grep ADMIN_USER | sed 's/.*=//')
echo password: $(kubectl -n jenkins --container jenkins exec $POD -- env | grep ADMIN_PASSWORD | sed 's/.*=//')
