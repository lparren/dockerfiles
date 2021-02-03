FROM oraclelinux:7-slim as base

ENV RUN_FILE="init.sh"  \
    INSTALL_DIR=/opt/install \
    ORACLE_HOME=/opt/oracle
        
ENV PATH="$PATH:$ORACLE_HOME/instantclient_21_1" \
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$ORACLE_HOME/instantclient_21_1"
    
ENV PATH=$PATH:$ORACLE_HOME/bin

COPY jdk-8u241-linux-x64.rpm ore-supporting-linux-x86-64-1.5.1.zip ore-client-linux-x86-64-1.5.1.zip $RUN_FILE $INSTALL_DIR/
COPY instantclient*.zip  $ORACLE_HOME/

RUN yum install -y yum-utils zip unzip git bzip2 initscripts systemd sudo wget && \
    yum-config-manager --enable ol7_optional_latest                       && \
    yum-config-manager --enable ol7_addons                                && \
    yum install -y oraclelinux-developer-release-el7                      && \
    yum install -y oracle-epel-release-el7                                && \
    yum-config-manager --enable ol7_developer                             && \
    yum groupinstall "X Window System"
    
# Install required packages including oracle client 
RUN yum install -y R python3 python3-devel libaio make libcurl-devel openssl-devel xml2 libxml2-devel libgit2-devel cairo-devel && \
    yum -y localinstall $INSTALL_DIR/jdk-8u241-linux-x64.rpm              && \
    cd $ORACLE_HOME                                                       && \
    unzip instantclient-basic-linux.x64-21.1.0.0.0.zip                    && \
    unzip instantclient-sqlplus-linux.x64-21.1.0.0.0.zip                  && \ 
    cd $INSTALL_DIR                                                       && \
    unzip ore-client-linux-x86-64-1.5.1.zip                               && \
    unzip ore-supporting-linux-x86-64-1.5.1.zip                          
    
# Upgrade pip and install packages for jupyter
RUN  python3 -m pip install --upgrade pip                                 && \
     python3 -m pip install jupyter grpcio protobuf                          

# Install R packages for zeppelin and ORE
RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')" && \
    R -e "install.packages('knitr', repos = 'http://cran.us.r-project.org')" && \
    R -e "install.packages('ggplot2', repos = 'http://cran.us.r-project.org')" && \
    R -e "install.packages(c('devtools','mplot', 'googleVis'), repos = 'http://cran.us.r-project.org'); require(devtools); install_github('ramnathv/rCharts')" && \    
    R -e "update.packages(ask = FALSE, repos = 'http://cran.us.r-project.org')" && \
    R CMD INSTALL $INSTALL_DIR/client/ORE_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz                && \
    R CMD INSTALL $INSTALL_DIR/client/OREbase_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz            && \
    R CMD INSTALL $INSTALL_DIR/client/OREcommon_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz          && \
    R CMD INSTALL $INSTALL_DIR/client/OREdm_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz              && \
    R CMD INSTALL $INSTALL_DIR/client/OREdplyr_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           && \
    R CMD INSTALL $INSTALL_DIR/client/OREeda_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz             && \
    R CMD INSTALL $INSTALL_DIR/client/OREembed_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           && \
    R CMD INSTALL $INSTALL_DIR/client/OREgraphics_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz        && \
    R CMD INSTALL $INSTALL_DIR/client/OREmodels_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz          && \
    R CMD INSTALL $INSTALL_DIR/client/OREpredict_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz         && \
    R CMD INSTALL $INSTALL_DIR/client/OREstats_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           && \
    R CMD INSTALL $INSTALL_DIR/client/ORExml_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz             && \
    R CMD INSTALL $INSTALL_DIR/supporting/Cairo_1.5-9_R_x86_64-unknown-linux-gnu.tar.gz          && \
    R CMD INSTALL $INSTALL_DIR/supporting/DBI_0.6-1_R_x86_64-unknown-linux-gnu.tar.gz            && \
    R CMD INSTALL $INSTALL_DIR/supporting/ROracle_1.3-2_R_x86_64-unknown-linux-gnu.tar.gz        && \
    R CMD INSTALL $INSTALL_DIR/supporting/arules_1.5-0_R_x86_64-unknown-linux-gnu.tar.gz         && \
    R CMD INSTALL $INSTALL_DIR/supporting/png_0.1-7_R_x86_64-unknown-linux-gnu.tar.gz            && \
    R CMD INSTALL $INSTALL_DIR/supporting/randomForest_4.6-12_R_x86_64-unknown-linux-gnu.tar.gz  && \
    R CMD INSTALL $INSTALL_DIR/supporting/statmod_1.4.29_R_x86_64-unknown-linux-gnu.tar.gz       

ENV JAVA_HOME=/usr/java/jdk1.8.0_241-amd64 \
    JRE_HOME=/usr/java/jdk1.8.0_241-amd64/jre    
    
# Install Zeppelin from binary
RUN wget http://www-us.apache.org/dist/zeppelin/zeppelin-0.9.0/zeppelin-0.9.0-bin-all.tgz && \
    tar -xvf zeppelin-*-bin-all.tgz -C /opt && \
    mv /opt/zeppelin-*-bin-all /opt/zeppelin    

COPY interpreter.json log4j.properties /zeppelin/conf/

ENV ZEPPELIN_ADDR=0.0.0.0
    
EXPOSE 8080

CMD $INSTALL_DIR/$RUN_FILE
