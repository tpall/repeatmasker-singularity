# RepeatMasker singularity image

This repo contains singularity image recipes for RepeatMasker 4.0.8 and 4.0.9(p2) together with RepBase RepeatMasker Edition database v20181026. RepBase RM database was installed from the private copy downloaded from [girinst.org](https://www.girinst.org/repbase) before them fully switching to a [subscription-based funding model](https://www.girinst.org/repbase/sub_announcement.html). 

Built images can be downloaded from Zenodo. 

## Usage

```
singularity exec /path/to/singularity409.simg /usr/local/bin/RepeatMasker test/seqs/small-1.fa
```
