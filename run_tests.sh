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
if [ $(singularity exec ${SINGULARITY_IMAGE} RepeatMasker | head -n 1 | awk -F'-' '{print $2}') = $(version) ]
then
  echo "Versions match"
else
  echo "Something is wrong with your test!"
fi

testDataDir="seqs/general/"
resultComparisonDir="seqs/general/small-1-rcmp-1/"
testFile="small-1.fa"
echo "\n# Testing - Simple Run -gc 43 $testDataDir$testFile\n"
cp $testDataDir$testFile wrkdir/$testFile
singularity exec ${SINGULARITY_IMAGE} RepeatMasker -engine crossmatch -gc 43 wrkdir/$testFile
cat wrkdir/$testFile.tbl | egrep -v \"RepeatMasker|cross_match|RepBase\" > wrkdir/$testFile.tbl.cmp
print "not " unless( 
  `diff -b wrkdir/$testFile.tbl.cmp $resultComparisonDir/$testFile.tbl.cmp` eq "" &&
  `diff wrkdir/$testFile.masked $resultComparisonDir/$testFile.masked` eq "" &&
  `diff wrkdir/$testFile.out $resultComparisonDir/$testFile.out` eq "" );
print "ok 1\n";


{ set +x; } 2>/dev/null
echo "All tests passed!"