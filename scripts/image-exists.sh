#!/bin/bash

IMAGE=$1
FILTER=$2

NB_IMAGE=$(gcloud container images list-tags $IMAGE --filter=$FILTER --limit=1|wc -l)

echo ${NB_IMAGE}
