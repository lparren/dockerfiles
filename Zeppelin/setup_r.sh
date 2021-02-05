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

cd $INSTALL_DIR        
unzip ore-client-linux-x86-64-1.5.1.zip
unzip ore-supporting-linux-x86-64-1.5.1.zip
 
R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')" 
R -e "install.packages('knitr', repos = 'http://cran.us.r-project.org')" 
R -e "install.packages('ggplot2', repos = 'http://cran.us.r-project.org')" 
R -e "install.packages(c('devtools','mplot', 'googleVis'), repos = 'http://cran.us.r-project.org'); require(devtools); install_github('ramnathv/rCharts')"    
R -e "update.packages(ask = FALSE, repos = 'http://cran.us.r-project.org')" 

R CMD INSTALL $INSTALL_DIR/client/ORE_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz               
R CMD INSTALL $INSTALL_DIR/client/OREbase_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           
R CMD INSTALL $INSTALL_DIR/client/OREcommon_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz         
R CMD INSTALL $INSTALL_DIR/client/OREdm_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz             
R CMD INSTALL $INSTALL_DIR/client/OREdplyr_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz          
R CMD INSTALL $INSTALL_DIR/client/OREeda_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz            
R CMD INSTALL $INSTALL_DIR/client/OREembed_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz          
R CMD INSTALL $INSTALL_DIR/client/OREgraphics_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz       
R CMD INSTALL $INSTALL_DIR/client/OREmodels_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz         
R CMD INSTALL $INSTALL_DIR/client/OREpredict_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz        
R CMD INSTALL $INSTALL_DIR/client/OREstats_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz          
R CMD INSTALL $INSTALL_DIR/client/ORExml_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz            
R CMD INSTALL $INSTALL_DIR/supporting/Cairo_1.5-9_R_x86_64-unknown-linux-gnu.tar.gz         
R CMD INSTALL $INSTALL_DIR/supporting/DBI_0.6-1_R_x86_64-unknown-linux-gnu.tar.gz           
R CMD INSTALL $INSTALL_DIR/supporting/ROracle_1.3-2_R_x86_64-unknown-linux-gnu.tar.gz       
R CMD INSTALL $INSTALL_DIR/supporting/arules_1.5-0_R_x86_64-unknown-linux-gnu.tar.gz        
R CMD INSTALL $INSTALL_DIR/supporting/png_0.1-7_R_x86_64-unknown-linux-gnu.tar.gz           
R CMD INSTALL $INSTALL_DIR/supporting/randomForest_4.6-12_R_x86_64-unknown-linux-gnu.tar.gz 
R CMD INSTALL $INSTALL_DIR/supporting/statmod_1.4.29_R_x86_64-unknown-linux-gnu.tar.gz      

R -e "install.packages('shiny', repos = 'http://cran.us.r-project.org')" 
R -e "install.packages('IRkernel', repos = 'http://cran.us.r-project.org')" 
R -e "IRkernel::installspec(user = FALSE, sys_prefix = TRUE)" 