#!/bin/bash

BRANCH_NAME=$1

if [[ "$BRANCH_NAME" =~ feature/*/* ]]
then
	NAMESPACE=$(cut -d'/' -f2 <<< ${BRANCH_NAME})
	echo ${NAMESPACE}
else
	echo ${BRANCH_NAME}
fi