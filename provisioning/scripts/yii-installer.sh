#!/usr/bin/env bash

SELF="${0##*/}"
USAGE="Usage: ${SELF} <PROJECT-NAME>"
EXAMPLE="Example: yii-create my-app"

if [[ $# != 1 ]]; then
    echo "${USAGE}"
    echo "${EXAMPLE}"
    exit 1
else
    PROJECT_NAME=${1}
fi

composer create-project --prefer-dist yiisoft/yii2-app-basic ${PROJECT_NAME}

exit $?
