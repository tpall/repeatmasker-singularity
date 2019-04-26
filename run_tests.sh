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
if [ $(singularity exec RepeatMasker | head -n 1 | awk -F'-' '{print $2}') = $(version) ]
then
  echo "Versions match"
else
  echo "Something is wrong with your test!"
fi

{ set +x; } 2>/dev/null
echo "All tests passed!"