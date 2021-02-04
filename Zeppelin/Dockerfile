FROM oraclelinux:7-slim as base

ENV RUN_FILE="init.sh"  \
    INSTALL_DIR=/opt/install \
    ORACLE_HOME=/opt/oracle
        
ENV PATH="$PATH:$ORACLE_HOME/instantclient_21_1" \
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$ORACLE_HOME/instantclient_21_1"
    
ENV PATH=$PATH:$ORACLE_HOME/bin

COPY jdk-8u241-linux-x64.rpm ore-supporting-linux-x86-64-1.5.1.zip ore-client-linux-x86-64-1.5.1.zip interpreter.json log4j.properties $RUN_FILE $INSTALL_DIR/
COPY instantclient*.zip  $ORACLE_HOME/

RUN chmod +x $INSTALL_DIR/$RUN_FILE

RUN yum install -y yum-utils zip unzip git bzip2 initscripts systemd sudo wget && \
    yum-config-manager --enable ol7_optional_latest                       && \
    yum-config-manager --enable ol7_addons                                && \
    yum install -y oraclelinux-developer-release-el7                      && \
    yum install -y oracle-epel-release-el7                                && \
    yum-config-manager --enable ol7_developer                             && \
    yum groupinstall -y "X Window System"                                 
    
# Install required packages including oracle client 
RUN yum -y localinstall $INSTALL_DIR/jdk-8u241-linux-x64.rpm                     
    
ENV JAVA_HOME=/usr/java/jdk1.8.0_241-amd64 \
    JRE_HOME=/usr/java/jdk1.8.0_241-amd64/jre    
 
ENV ZEPPELIN_ADDR=0.0.0.0
    
EXPOSE 8080

#CMD $INSTALL_DIR/$RUN_FILE
sleep infinity