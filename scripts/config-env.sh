#!/bin/bash

FROM=$1
IMAGE_NAME=$3
SHORT_SHA=$4

env_from_branche_name() {

    BRANCH_NAME=$1
    if [[ "$BRANCH_NAME" =~ feature/* ]]
    then
        echo feat
    elif [[ "$BRANCH_NAME" =~ develop ]]
    then
        echo int
    elif [[ "$BRANCH_NAME" =~ release/* ]]
    then
        echo stg
    fi
}

version_from_branche_name() {

    BRANCH_NAME=$1
    if [[ "$BRANCH_NAME" =~ feature/* ]]
    then
        VERSION=$(cut -d'/' -f2 <<< ${BRANCH_NAME})
        echo ${VERSION}
    elif [[ "$BRANCH_NAME" =~ develop ]]
    then
        echo int
    elif [[ "$BRANCH_NAME" =~ release/* ]]
    then
        VERSION=$(cut -d'/' -f2 <<< ${BRANCH_NAME})
        echo ${VERSION}-rc
    fi
}

is_image_exist() {
    IMAGE=$1
    FILTER=$2

    NB_IMAGE=$(gcloud container images list-tags $IMAGE --filter=$FILTER --limit=1|wc -l)

    if [[ $NB_IMAGE -eq 0 ]]
    then
        echo false
    else
        echo true
    fi
}



if [[ "$FROM" = branche ]]
then
    ENV=$(env_from_branche_name $2)
    VERSION=$(version_from_branche_name $2)
    EXIST=$(is_image_exist $IMAGE_NAME $SHORT_SHA)
fi

echo "export ENV=$ENV"
echo "export VERSION=$VERSION"
echo "export IMAGE_NAME=$IMAGE_NAME"
echo "export IS_IMAGE_EXIST=$EXIST"