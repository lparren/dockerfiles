FROM oraclelinux:8

ENV LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH} \
    ORACLE_HOME=/usr/lib/oracle/21/client64  \
    PATH=$PATH:$ORACLE_HOME/bin 

RUN mkdir -p /opt/install && \
    mkdir -p /usr


COPY python38.module /etc/dnf/modules.d/python38.module
COPY oracle-instantclient* /opt/install/    

# Install python3.8
RUN yum install -y python38 python38-libs python38-pip python38-setuptools && \
    yum install -y unzip git bzip2 wget && \                   
    yum clean all
    
RUN yum install -y /opt/install/oracle-instantclient*.rpm

# Upgrade pip otherwise dbt install leads to error
RUN pip3 install --upgrade pip

# Install dbt
RUN pip3 install dbt==0.19.0 cx_Oracle

CMD [dbt]