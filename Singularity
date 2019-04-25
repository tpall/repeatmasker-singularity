BootStrap: docker
From: debian:stretch

%labels
  Maintainer tpall
  RM_Version 4.0.9
  RMBlast Version 2.9.0
  TRF Version 4.09
  Repbase_Version 20181026

%apprun RepeatMasker
  exec RepeatMasker "${@}"

%runscript
  exec RepeatMasker "${@}"

%post
  # Software versions
  export RM_VERSION=${RM_VERSION:-4.0.9}
  export RMB_VERSION=${RMB_VERSION:-2.9.0}
  export TRF_VERSION=${TRF_VERSION:-409}
  export REPBASE_VER=${REPBASE_VER:-20181026}

 # Get build dependencies
  apt-get update \
  && apt-get install -y --no-install-recommends wget build-essential \
  && cd tmp

  ## Download RMBlast source code
  wget -O ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/${RMB_VERSION}/ncbi-blast-${RMB_VERSION}+-src.tar.gz
  wget http://www.repeatmasker.org/isb-${RMB_VERSION}+-rmblast.patch.gz
  tar zxvf ncbi-blast-${RMB_VERSION}+-src.tar.gz \
    && gunzip isb-${RMB_VERSION}+-rmblast.patch.gz \
    && cd ncbi-blast-${RMB_VERSION}+-src \
    && patch -p1 < ../isb-${RMB_VERSION}+-rmblast.patch
  
  ## Configure RMBlast
  cd c++ \
    && ./configure --with-mt --without-debug --without-krb5 --without-openssl --with-projects=scripts/projects/rmblastn/project.lst --prefix=/usr/local/rmblast

  ## Build and install RMBlast
  make \
    && make install

  ## Download TRF
  cd /tmp \
    && wget http://tandem.bu.edu/trf/downloads/trf${TRF_VERSION}.linux64 \
    && cp trf${TRF_VERSION}.linux64 /usr/local/bin/

  ## Download RepeatMasker
  wget http://www.repeatmasker.org/RepeatMasker-open-$(echo $RM_VERSION | sed -e 's/\./\-/g').tar.gz
  cp RepeatMasker-open-$(echo $RM_VERSION | sed -e 's/\./\-/g').tar.gz /usr/local/
  cd /usr/local/ \
    && gunzip RepeatMasker-open-$(echo $RM_VERSION | sed -e 's/\./\-/g').tar.gz \
    && tar xvf RepeatMasker-open-$(echo $RM_VERSION | sed -e 's/\./\-/g').tar

  ## Download RepBase RepeatMasker Edition
  wget --user $GIRUSER --password $GIRPASS https://www.girinst.org/server/RepBase/protected/repeatmaskerlibraries/RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar.gz
  cp RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar.gz /usr/local/RepeatMasker/
  cd /usr/local/RepeatMasker \
    && gunzip RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar.gz \
    && tar xvf RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar \
    && rm RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar

  ## Run Configure Script
  perl ./configure

  ## Clean up from source install
  cd / \
  && rm -rf /tmp/* \
  && apt-get remove --purge -y $BUILDDEPS \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/*
  