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

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $INSTALL_DIR/$CONTAINER_ALREADY_STARTED ]; then
    touch $INSTALL_DIR/$CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"   
    
    sed -i -e "s|###ORACLE_CONNECT###|$ORACLE_CONNECT|g" $INSTALL_DIR/interpreter.json
    sed -i -e "s|###ORACLE_USER###|$ORACLE_USER|g" $INSTALL_DIR/interpreter.json
    sed -i -e "s|###ORACLE_PASSWORD###|$ORACLE_PASSWORD|g" $INSTALL_DIR/interpreter.json

    chmod 775 $INSTALL_DIR/interpreter.json
    cp $INSTALL_DIR/interpreter.json /opt/zeppelin/conf/    
fi

echo "******************************************************************************"
echo "Start Zeppelin" `date`
echo "******************************************************************************"

alias pip="pip3" #zodat zeppelin de juiste versie gebruikt

/opt/zeppelin/bin/zeppelin.sh