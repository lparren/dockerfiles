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
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"

    sed -i -e "s|###ORACLE_CONNECT###|$ORACLE_CONNECT|g" /zeppelin/conf/interpreter_osql.json
    sed -i -e "s|###ORACLE_USER###|$ORACLE_USER|g" /zeppelin/conf/interpreter_osql.json
    sed -i -e "s|###ORACLE_PASSWORD###|$ORACLE_PASSWORD|g" /zeppelin/conf/interpreter_osql.json
fi

/zeppelin/bin/zeppelin.sh
