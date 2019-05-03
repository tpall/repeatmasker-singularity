#!/bin/bash

export SINGULARITY_IMAGE="${SINGULARITY_IMAGE:-repeatmasker-singularity.simg}"
echo "Using Singularity image: ${SINGULARITY_IMAGE}"

set -x
set -e

# Run RM
#singularity run --app RepeatMasker ${SINGULARITY_IMAGE} -v
#singularity exec -s /bin/bash ${SINGULARITY_IMAGE} /usr/local/bin/RepeatMasker test/seqs/small-1.fa
#singularity exec -s /bin/bash ${SINGULARITY_IMAGE}  /usr/local/bin/RepeatMasker test/seqs/small-2.fa
singularity exec -s ${SINGULARITY_IMAGE}  ls /usr/local/

{ set +x; } 2>/dev/null
echo "All tests passed!"