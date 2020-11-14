#!/bin/bash

FROM=$1
IMAGE_NAME=$3
SHORT_SHA=$4

env_from_branch_name() {

    BRANCH_NAME=$1
    if [[ "$BRANCH_NAME" =~ ^feature//* ]]
    then
        echo feat
    elif [[ "$BRANCH_NAME" =~ ^develop$ ]]
    then
        echo int
    elif [[ "$BRANCH_NAME" =~ ^release//* ]]
    then
        echo stg
    else
        exit 1
    fi
}

env_from_tag_name() {

    TAG_NAME=$1
    if [[ "$TAG_NAME" =~ ^v[0-9]\.[0-9]\.[0-9|x|X]-rc$ ]]
    then
        echo stg
    elif [[ "$TAG_NAME" =~ ^v[0-9]\.[0-9]\.[0-9]$ ]]
    then
        echo prod
    else
        exit 1
    fi
}

version_from_branch_name() {

    BRANCH_NAME=$1
    if [[ "$BRANCH_NAME" =~ ^feature//* ]]
    then
        VERSION=$(cut -d'/' -f2 <<< ${BRANCH_NAME})
        echo ${VERSION}
    elif [[ "$BRANCH_NAME" =~ ^develop$ ]]
    then
        echo int
    elif [[ "$BRANCH_NAME" =~ ^release//* ]]
    then
        VERSION=$(cut -d'/' -f2 <<< ${BRANCH_NAME})
        echo ${VERSION}-rc
    else
        exit 1
    fi
}

version_from_tag_name() {
    TAG_NAME=$1
    echo ${TAG_NAME:1}
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

check() {
    if [[ -z "$ENV" || -z "$VERSION" || -z "$EXIST" ]]
    then
        exit 1
    fi
}

if [[ "$FROM" = branch ]]
then
    ENV=$(env_from_branch_name $2)
    VERSION=$(version_from_branch_name $2)
    EXIST=$(is_image_exist $IMAGE_NAME $SHORT_SHA)
elif [[ "$FROM" = tag ]]
then
    ENV=$(env_from_tag_name $2)
    VERSION=$(version_from_tag_name $2)
    EXIST=$(is_image_exist $IMAGE_NAME $SHORT_SHA)
fi

check

echo "export ENV=$ENV"
echo "export VERSION=$VERSION"
echo "export IMAGE_NAME=$IMAGE_NAME"
echo "export IS_IMAGE_EXIST=$EXIST"