#!/usr/bin/env bash

SELF="${0##*/}"
USAGE="Usage: ${SELF} <PROJECT-NAME>"
EXAMPLE="Example: laminas-create my-app"

if [[ $# != 1 ]]; then
    echo "${USAGE}"
    echo "${EXAMPLE}"
    exit 1
else
    PROJECT_NAME=${1}
fi

composer create-project -s dev laminas/laminas-mvc-skeleton ${PROJECT_NAME}

exit $?
