#!/bin/bash -Eeu

readonly REGEX="image_name\": \"(.*)\""
readonly JSON=$(cat docker/image_name.json)
[[ ${JSON} =~ ${REGEX} ]]
readonly IMAGE_NAME="${BASH_REMATCH[1]}"

readonly MY_DIR="$(cd "$(dirname "${0}")" && pwd)"
readonly EXPECTED='jq-1.7.1'
readonly ACTUAL=$(docker run --rm -it ${IMAGE_NAME} sh -c 'jq --version')

if echo "${ACTUAL}" | grep -q "${EXPECTED}"; then
  echo "VERSION CONFIRMED as ${EXPECTED}"
else
  echo "VERSION EXPECTED: ${EXPECTED}"
  echo "VERSION   ACTUAL: ${ACTUAL}"
  exit 42
fi
