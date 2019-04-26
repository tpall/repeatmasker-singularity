#!/bin/bash

export SINGULARITY_IMAGE="${SINGULARITY_IMAGE:-repeatmasker-singularity.simg}"
echo "Using Singularity image: ${SINGULARITY_IMAGE}"

version () {
  singularity inspect "${SINGULARITY_IMAGE}" | \
    grep "RM_VERSION" | \
    awk -F'"' '{print $4}'
}

set -e
set -x

# Verify RM version
if [ $(singularity exec ${SINGULARITY_IMAGE} -v) = $(version) ]
then
   echo "all right, version's correct!"
else
  echo "something's wrong with test"
fi

{ set +x; } 2>/dev/null
echo "All tests passed!"