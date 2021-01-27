FROM apache/zeppelin:0.9.0

ENV RUN_FILE="init.sh"  \
    INSTALL_DIR=/opt/install \
    PATH="$PATH:/opt/oracle/instantclient_21_1" \
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/oracle/instantclient_21_1"

COPY interpreter.json /zeppelin/conf/
COPY $RUN_FILE $INSTALL_DIR/
COPY instantclient*.zip  /opt/oracle/
COPY ore-supporting-linux-x86-64-1.5.1.zip ore-client-linux-x86-64-1.5.1.zip $INSTALL_DIR/

USER root

# Update packages, the update R to 3.6.1
# update all R packages
# install oracle client and Oracle R Enterprise (ORE) packages
RUN apt-get update -y  && \
    apt-get install -y apt-transport-https  && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/'   && \
    apt-get update -y  && \
    apt-get install -y r-base  && \
    apt-get install -y r-base-dev  && \
    chmod ug+x $INSTALL_DIR/*.sh  && \
    cd /opt/oracle && \
    unzip instantclient-basic-linux.x64-21.1.0.0.0.zip && \
    unzip instantclient-sqlplus-linux.x64-21.1.0.0.0.zip && \
    cd /opt/install && \
    apt-get install zlib1g-dev && \
    wget http://prdownloads.sourceforge.net/libpng/libpng-1.5.4.tar.gz && \
    tar xzf libpng-1.5.4.tar.gz && \
    cd libpng-1.5.4/  && \
    ./configure --prefix=/usr/local/libpng && \
    make && \
    make install && \
    cd /opt/install && \
    unzip ore-client-linux-x86-64-1.5.1.zip && \
    unzip ore-supporting-linux-x86-64-1.5.1.zip && \
    R -e 'update.packages(checkBuilt = TRUE, ask = FALSE)' && \
    R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')" && \
    R -e "install.packages('knitr', repos = 'http://cran.us.r-project.org')" && \
    R -e "install.packages('ggplot2', repos = 'http://cran.us.r-project.org')" && \
    R -e "install.packages(c('devtools','mplot', 'googleVis'), repos = 'http://cran.us.r-project.org'); require(devtools); install_github('ramnathv/rCharts')" && \
    R CMD INSTALL /opt/install/client/ORE_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz                && \
    R CMD INSTALL /opt/install/client/OREbase_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz            && \
    R CMD INSTALL /opt/install/client/OREcommon_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz          && \
    R CMD INSTALL /opt/install/client/OREdm_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz              && \
    R CMD INSTALL /opt/install/client/OREdplyr_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           && \
    R CMD INSTALL /opt/install/client/OREeda_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz             && \
    R CMD INSTALL /opt/install/client/OREembed_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           && \
    R CMD INSTALL /opt/install/client/OREgraphics_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz        && \
    R CMD INSTALL /opt/install/client/OREmodels_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz          && \
    R CMD INSTALL /opt/install/client/OREpredict_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz         && \
    R CMD INSTALL /opt/install/client/OREstats_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           && \
    R CMD INSTALL /opt/install/client/ORExml_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz             && \
    R CMD INSTALL /opt/install/supporting/Cairo_1.5-9_R_x86_64-unknown-linux-gnu.tar.gz          && \
    R CMD INSTALL /opt/install/supporting/DBI_0.6-1_R_x86_64-unknown-linux-gnu.tar.gz            && \
    R CMD INSTALL /opt/install/supporting/ROracle_1.3-2_R_x86_64-unknown-linux-gnu.tar.gz        && \
    R CMD INSTALL /opt/install/supporting/arules_1.5-0_R_x86_64-unknown-linux-gnu.tar.gz         && \
    R CMD INSTALL /opt/install/supporting/png_0.1-7_R_x86_64-unknown-linux-gnu.tar.gz            && \
    R CMD INSTALL /opt/install/supporting/randomForest_4.6-12_R_x86_64-unknown-linux-gnu.tar.gz  && \
    R CMD INSTALL /opt/install/supporting/statmod_1.4.29_R_x86_64-unknown-linux-gnu.tar.gz

CMD exec $INSTALL_DIR/$RUN_FILE
