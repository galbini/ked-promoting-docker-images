#!/bin/bash

IMAGE=$1
FILTER=$2

NB_IMAGE=$(gcloud container images list-tags $IMAGE --filter=$FILTER --limit=1|wc -l)

if [[ $NB_IMAGE -eq 0 ]]
then
    echo true
else
    echo false
fi