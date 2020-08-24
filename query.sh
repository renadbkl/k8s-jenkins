#!/bin/bash
POD=$(kubectl get pods -n jenkins -o json | jq '.items[1].metadata.name' | xargs)
echo "Jenkins credentials"
echo username: $(kubectl -n jenkins --container jenkins exec $POD -- env | grep ADMIN_USER | sed 's/.*=//')
echo password: $(kubectl -n jenkins --container jenkins exec $POD -- env | grep ADMIN_PASSWORD | sed 's/.*=//')
echo port: $(kubectl get service jenkins -n jenkins -o json | jq '.spec.ports[0].nodePort')
