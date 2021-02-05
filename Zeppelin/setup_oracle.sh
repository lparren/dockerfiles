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

echo "******************************************************************************"
echo "Install Oracle client" `date`
echo "******************************************************************************"

unzip $ORACLE_HOME/instantclient-basic-linux.x64-21.1.0.0.0.zip -d $ORACLE_HOME
unzip $ORACLE_HOME/instantclient-sqlplus-linux.x64-21.1.0.0.0.zip -d $ORACLE_HOME

rm instantclient-*-linux.x64-21.1.0.0.0.zip