#!/bin/bash
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2018 Oracle and/or its affiliates. All rights reserved.
#
# Since: November, 2016
# Author: gerald.venzl@oracle.com
# Description: Runs the Oracle Database inside the container
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

    cd /zeppelin/conf

    csplit interpreter.json /influxdb/
    mv interpreter.json interpreter.json.old

    sed -i -e "s|###ORACLE_CONNECT###|$ORACLE_CONNECT|g" interpreter_osql.json
    sed -i -e "s|###ORACLE_USER###|$ORACLE_USER|g" interpreter_osql.json
    sed -i -e "s|###ORACLE_PASSWORD###|$ORACLE_PASSWORD|g" interpreter_osql.json

    cat xx00 interpreter_osql.json xx01 > interpreter.json
fi

cd /
/zeppelin/bin/zeppelin.sh
