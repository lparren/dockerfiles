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

tar -xvf $INSTALL_DIR/zeppelin-*-bin-all.tgz -C /opt 
mv /opt/zeppelin-*-bin-all /opt/zeppelin    
