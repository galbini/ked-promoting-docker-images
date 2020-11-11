#!/bin/bash

FROM=$1

from_branche_name() {

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

if [[ "$FROM" = branche ]]
then
    from_branche_name $2
fi