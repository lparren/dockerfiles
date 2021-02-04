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
echo "Install Zeppelin from binary" `date`
echo "******************************************************************************"

wget http://www-us.apache.org/dist/zeppelin/zeppelin-0.9.0/zeppelin-0.9.0-bin-all.tgz 
tar -xvf zeppelin-*-bin-all.tgz -C /opt 
mv /opt/zeppelin-*-bin-all /opt/zeppelin    

sed -i -e "s|###ORACLE_CONNECT###|$ORACLE_CONNECT|g" $INSTALL_DIR/interpreter.json
sed -i -e "s|###ORACLE_USER###|$ORACLE_USER|g" $INSTALL_DIR/interpreter.json
sed -i -e "s|###ORACLE_PASSWORD###|$ORACLE_PASSWORD|g" $INSTALL_DIR/interpreter.json

cp $INSTALL_DIR/interpreter.json /opt/zeppelin/conf/

