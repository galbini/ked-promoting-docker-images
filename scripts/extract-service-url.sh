#!/bin/bash

NAMESPACE=$1
SERVICE_NAME=$2

URL=$(gcloud run services list --platform managed | grep $NAMESPACE-$SERVICE_NAME | cut -d ' ' -f 7)

echo ${URL}
