FROM oraclelinux:7-slim as base

ENV Z_VERSION="0.9.0"

ENV LOG_TAG="[ZEPPELIN_${Z_VERSION}]:" \
    INSTALL_DIR=/opt/install \
    Z_HOME="/opt/zeppelin" \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    JAVA_HOME=/usr/java/jdk1.8.0_241-amd64 \
    JRE_HOME=/usr/java/jdk1.8.0_241-amd64/jre \
    ZEPPELIN_ADDR="0.0.0.0" \
    A_HOME="/root"

COPY jdk-8u241-linux-x64.rpm  zeppelin-${Z_VERSION}-bin-all.tgz $INSTALL_DIR/

RUN echo "$LOG_TAG install basic packages" && \
    yum install -y yum-utils zip unzip git bzip2 initscripts systemd sudo wget && \
    yum install -y oraclelinux-developer-release-el7                      && \
    yum install -y oracle-epel-release-el7                                && \
    yum-config-manager --enable ol7_optional_latest ol7_addons ol7_developer && \
    yum -y update && \
    yum install -y R R-devel libcurl-devel openssl-devel && \
    yum -y localinstall $INSTALL_DIR/jdk-8u241-linux-x64.rpm 

# Install conda to manage python and R packages
ARG miniconda_version="py37_4.9.2"
# Hashes via https://docs.conda.io/en/latest/miniconda_hashes.html
ARG miniconda_sha256="79510c6e7bd9e012856e25dcb21b3e093aa4ac8113d9aa7e82a86987eabe1c31"

RUN wget -nv https://repo.anaconda.com/miniconda/Miniconda3-${miniconda_version}-Linux-x86_64.sh -O miniconda.sh && \
    echo "${miniconda_sha256} miniconda.sh" > anaconda.sha256 && \
    sha256sum --strict -c anaconda.sha256 && \
    bash miniconda.sh -b -p $A_HOME/conda && \
    export PATH=$A_HOME/conda/bin:$PATH && \
    conda config --set always_yes yes --set changeps1 no && \
    conda info -a
    
ENV PATH $A_HOME/conda/bin:$PATH   
    
RUN conda install -c conda-forge pycodestyle numpy=1 pandas=0.25 scipy=1 grpcio hvplot protobuf=3 pandasql=0.7.3 ipython=7 matplotlib=3 ipykernel=5 && \
    conda install -c conda-forge jupyter_client=5 bokeh=1.3.4 panel holoviews pyyaml=3 altair intake plotnine seaborn pip tensorflow keras&& \
    conda install -c r r-base=3 r-evaluate r-base64enc r-knitr r-ggplot2 r-irkernel r-shiny r-googlevis r-essentials r-base r-rlang && \
    conda env export -n base --no-builds > environment.yml && \  
    conda init bash && \
    pip install bkzep
    
    
#RUN rm -v miniconda.sh anaconda.sha256  && \
#    # Cleanup based on https://github.com/ContinuumIO/docker-images/commit/cac3352bf21a26fa0b97925b578fb24a0fe8c383
#    find $A_HOME/conda/ -follow -type f -name '*.a' -delete && \
#    find $A_HOME/conda/ -follow -type f -name '*.js.map' -delete && \
#    conda clean -ay
#    # Allow to modify conda packages. This allows malicious code to be injected into other interpreter sessions, therefore it is disabled by default
#    # chmod -R ug+rwX $A_HOME/conda
    
RUN echo "$LOG_TAG Download Zeppelin binary" && \
    mkdir -p ${Z_HOME} && \
    tar --strip-components=1 -zxvf  $INSTALL_DIR/zeppelin-${Z_VERSION}-bin-all.tgz -C ${Z_HOME} && \
    chown -R root:root ${Z_HOME} && \
    mkdir -p ${Z_HOME}/logs ${Z_HOME}/run ${Z_HOME}/webapps && \
    # Allow process to edit /etc/passwd, to create a user entry for zeppelin
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    # Give access to some specific folders
    chmod -R 775 "${Z_HOME}/logs" "${Z_HOME}/run" "${Z_HOME}/notebook" "${Z_HOME}/conf" && \
    # Allow process to create new folders (e.g. webapps)
    chmod 775 ${Z_HOME}

COPY log4j.properties ${Z_HOME}/conf/
COPY log4j_docker.properties ${Z_HOME}/conf/    

USER 1000

EXPOSE 8080

WORKDIR ${Z_HOME}
CMD sleep infinity
