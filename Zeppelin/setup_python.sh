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
echo "Install R packages for zeppelin and ORE" `date`
echo "******************************************************************************"

# Upgrade pip and install packages for jupyter
python3 -m pip install --upgrade pip
python3 -m pip install wheel jupyter grpcio protobuf matplotlib Pandas Seaborn Plotnine Bokeh Holoviews Altair 