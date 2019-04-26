BootStrap: docker
From: debian:stretch

%labels
  Maintainer tpall
  RM_Version 4.0.9
  RMBlast Version 2.9.0
  TRF Version 4.09
  Repbase_Version 20181026

%apprun RepeatMasker
  exec /usr/local/RepeatMasker/RepeatMasker "${@}"

%runscript
  exec /usr/local/RepeatMasker/RepeatMasker "${@}"

%post
  # Software versions
  export RM_VERSION=${RM_VERSION:-4.0.9}
  export RMB_VERSION=${RMB_VERSION:-2.9.0}
  export TRF_VERSION=${TRF_VERSION:-409}
  export REPBASE_VER=${REPBASE_VER:-20181026}

 # Get build dependencies
  apt-get update \
    && apt-get install -y --no-install-recommends wget build-essential cpanminus

  # Configure term
  export TERM=xterm

  ## Download RMBlast
  cd /tmp
  wget -nv http://www.repeatmasker.org/rmblast-${RMB_VERSION}+-x64-linux.tar.gz
  cd /usr/local \
    && tar zxvf /tmp/rmblast-${RMB_VERSION}+-x64-linux.tar.gz

  ## Download TRF
  cd /tmp
  wget -nv http://tandem.bu.edu/trf/downloads/trf${TRF_VERSION}.linux64
  cp trf${TRF_VERSION}.linux64 /usr/local/bin/

  ## Download RepeatMasker
  wget -nv http://www.repeatmasker.org/RepeatMasker-open-$(echo $RM_VERSION | sed -e 's/\./\-/g').tar.gz
  cp RepeatMasker-open-$(echo $RM_VERSION | sed -e 's/\./\-/g').tar.gz /usr/local/
  cd /usr/local/ \
    && gunzip RepeatMasker-open-$(echo $RM_VERSION | sed -e 's/\./\-/g').tar.gz \
    && tar xvf RepeatMasker-open-$(echo $RM_VERSION | sed -e 's/\./\-/g').tar
  
  # Install the Text::Soundex module via cpan:
  cpanm -S Text::Soundex

  ## Download RepBase RepeatMasker Edition
  wget -nv --user $GIRUSER --password $GIRPASS --no-check-certificate https://www.girinst.org/server/RepBase/protected/repeatmaskerlibraries/RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar.gz
  cp RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar.gz /usr/local/RepeatMasker/
  cd /usr/local/RepeatMasker \
    && gunzip RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar.gz \
    && tar xvf RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar \
    && rm RepBaseRepeatMaskerEdition-${REPBASE_VER}.tar

  ## Run Configure Script
  perl ./configure --trfbin=/usr/local/bin/trf${TRF_VERSION}.linux64 --rmblastbin=/usr/local/rmblast-2.9.0/rmblastn

  ## Clean up from source install
  cd / \
  && rm -rf /tmp/* \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/*
