[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.2671673.svg)](https://doi.org/10.5281/zenodo.2671673)  [![Build Status](https://travis-ci.org/tpall/repeatmasker-singularity.svg?branch=master)](https://travis-ci.org/tpall/repeatmasker-singularity)

# RepeatMasker singularity image

**conda** branch is built on top of *continuumio/miniconda3:latest* instead of debian:latest (master branch).

This repo contains singularity image recipes for RepeatMasker 4.0.8 and 4.0.9(p2) together with RepBase RepeatMasker Edition database v20181026. 

RepBase RM database was installed from the private copy downloaded from [girinst.org](https://www.girinst.org/repbase) before they switched to a [subscription-based funding model](https://www.girinst.org/repbase/sub_announcement.html). 

Built RM-4.0.9p2 image can be downloaded from Zenodo. 

## Usage

Command line:
```
singularity exec /path/to/repeatmasker409.simg /usr/local/bin/RepeatMasker test/seqs/small-1.fa
```
