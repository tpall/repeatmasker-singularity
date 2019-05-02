#!/bin/bash

export SINGULARITY_IMAGE="repeatmasker-singularity.simg"
echo "Using Singularity image: ${SINGULARITY_IMAGE}"

version () {
  singularity inspect "${SINGULARITY_IMAGE}" | \
    grep "RM_VERSION" | \
    awk -F'"' '{print $4}'
}

set -e
set -x

# Run RM
singularity exec ${SINGULARITY_IMAGE} /usr/local/bin/RepeatMasker test/seqs/small-1.fa
singularity exec ${SINGULARITY_IMAGE}  /usr/local/bin/RepeatMasker test/seqs/small-2.fa

{ set +x; } 2>/dev/null
echo "All tests passed!"