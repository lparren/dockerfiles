FROM oraclelinux:7-slim as base

ENV RUN_FILE="init.sh"  \
    INSTALL_DIR=/opt/install \
    ORACLE_HOME=/opt/oracle \
    SETUP_R="setup_r.sh" \
    SETUP_PYTHON="setup_python.sh" \
    SETUP_ZEPPELIN="setup_zeppelin.sh" \
    ZEPPELIN_SRC="zeppelin-0.9.0-bin-all.tgz"
        
ENV PATH="$PATH:$ORACLE_HOME/instantclient_21_1" \
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$ORACLE_HOME/instantclient_21_1"
    
ENV PATH=$PATH:$ORACLE_HOME/bin

COPY jdk-8u241-linux-x64.rpm ore-supporting-linux-x86-64-1.5.1.zip ore-client-linux-x86-64-1.5.1.zip interpreter.json log4j.properties $RUN_FILE $SETUP_R $SETUP_PYTHON $SETUP_ZEPPELIN $ZEPPELIN_SRC $INSTALL_DIR/
COPY instantclient*.zip  $ORACLE_HOME/

RUN yum install -y yum-utils zip unzip git bzip2 initscripts systemd sudo wget && \
    yum install -y oraclelinux-developer-release-el7                      && \
    yum install -y oracle-epel-release-el7                                && \
    yum-config-manager --enable ol7_optional_latest ol7_addons ol7_developer && \
    yum groupinstall "X Window System"
    
# Install required packages including oracle client 
RUN yum install -y R python3 python3-devel libaio make libcurl-devel openssl-devel xml2 libxml2-devel libgit2-devel cairo-devel    && \
    yum -y localinstall $INSTALL_DIR/jdk-8u241-linux-x64.rpm                     

#RUN chmod ug+x $INSTALL_DIR/*.sh && \
#    sync && \
#    $INSTALL_DIR/$SETUP_ORACLE && \
#    $INSTALL_DIR/$SETUP_R && \
#    $INSTALL_DIR/$SETUP_PYTHON && \
#    $INSTALL_DIR/$SETUP_ZEPPELIN 
    
ENV JAVA_HOME=/usr/java/jdk1.8.0_241-amd64 \
    JRE_HOME=/usr/java/jdk1.8.0_241-amd64/jre    
 
ENV ZEPPELIN_ADDR=0.0.0.0
    
EXPOSE 8080

#CMD $INSTALL_DIR/$RUN_FILE
CMD sleep infinity