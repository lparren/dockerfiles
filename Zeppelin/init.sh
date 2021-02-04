#!/bin/bash
# LICENSE UPL 1.0
#
# Copyright (c) 2011 TheDOC. All rights reserved.
#
# Since: November, 2016
# Author: l.parren@thedoc.nl
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#

if [ "$ORACLE_CONNECT" == "" ]; then
  echo "Error: The ORACLE_CONNECT must be provided"
  exit 1;
fi

if [ "$ORACLE_USER" == "" ]; then
  echo "Error: The ORACLE_USER must be provided"
  exit 1;
fi

if [ "$ORACLE_PASSWORD" == "" ]; then
  echo "Error: The ORACLE_PASSWORD must be provided"
  exit 1;
fi

CONTAINER_ALREADY_STARTED="$$INSTALL_DIR/CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    
    yum install -y R python3 python3-devel libaio make libcurl-devel openssl-devel xml2 libxml2-devel libgit2-devel cairo-devel    

    /vagrant/scripts/setup_r.sh
    /vagrant/scripts/setup_python.sh
    /vagrant/scripts/setup_zeppelin.sh      
fi

echo "******************************************************************************"
echo "Start Zeppelin" `date`
echo "******************************************************************************"

/opt/zeppelin/bin/zeppelin.sh