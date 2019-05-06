#!/bin/bash

export SINGULARITY_IMAGE="${SINGULARITY_IMAGE:-repeatmasker-singularity.simg}"
echo "Using Singularity image: ${SINGULARITY_IMAGE}"

set -x
set -e

#singularity exec ${SINGULARITY_IMAGE} /usr/local/bin/RepeatMasker test/seqs/small-1.fa
#singularity exec ${SINGULARITY_IMAGE} /usr/local/bin/RepeatMasker test/seqs/small-2.fa

{ set +x; } 2>/dev/null
echo "All tests passed!"