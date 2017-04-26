#!/bin/bash

## Variables
# USERNAME: username for your own local user
# USERPASSWORD: password for local user
# OWNCLOUDUSERNAME: Username for your owncloudservice
# OWNCLOUDPASSWORD: Password for your owncloudservice
# OWNCLOUDWEBDAV: WebDAV address for your owncloudservice
USERNAME="xxx"
USERPASSWORD="xxx"
OWNCLOUDUSERNAME="xxx"
OWNCLOUDPASSWORD="xxx"
OWNCLOUDWEBDAV="xxx"

# add local user
adduser $USERNAME --disabled-password --gecos ""
echo -e "$USERPASSWORD\n$USERPASSWORD\n" | passwd $USERNAME
usermod -aG sudo $USERNAME

# Enable sources, add PPAs and update sources:
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"

# Add repository for R
add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/"

# Add repository for GIS software
add-apt-repository ppa:ubuntugis/ubuntugis-unstable


# Fetch keys for R repository
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | apt-key add -

# Update and upgrade everything
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade

# Symlinking home folders.
cd
mkdir Downloads/ Data/ Share/

## Adding software:
# some dependencies for R packages and the following software
apt-get install -y --force-yes r-base r-base-dev gdebi-core davfs2 libgdal-dev libproj-dev

## Download RStudio and shiny server (check links for newer versions)
# 1. https://www.rstudio.com/products/shiny/download-server/
# 2. https://www.rstudio.com/products/rstudio/download-server/
cd Downloads/
wget https://download2.rstudio.org/rstudio-server-1.0.136-amd64.deb
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.1.834-amd64.deb

# Install both
gdebi --non-interactive rstudio-server-1.0.136-amd64.deb
sudo su - \
-c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
gdebi --non-interactive shiny-server-1.5.1.834-amd64.deb
cd

# mount owncloud via webdav
usermod -aG davfs2 $USERNAME
mkdir /home/$USERNAME/owncloud
mkdir /home/$USERNAME/.davfs2
cp  /etc/davfs2/secrets /home/$USERNAME/.davfs2/secrets
chown $USERNAME:$USERNAME  /home/$USERNAME/.davfs2/secrets
chmod 600 /home/$USERNAME/.davfs2/secrets
sed -i '/user config file only/s/^#//g' /etc/davfs2/davfs2.conf
echo "https://$OWNCLOUDWEBDAV/remote.php/webdav/ $OWNCLOUDUSERNAME $OWNCLOUDPASSWORD" >> /home/$USERNAME/.davfs2/secrets
echo "https://$OWNCLOUDWEBDAV/remote.php/webdav/ /home/$USERNAME/owncloud davfs user,rw,auto 0 0" >> /etc/fstab
mount /home/$USERNAME/owncloud
chown $USERNAME:$USERNAME -R /home/$USERNAME/owncloud

## setup glances to monitor server
# https://github.com/nicolargo/glances
wget -O- https://bit.ly/glances | /bin/bash

echo -e "[Unit]
Description=Glances

[Service]
ExecStart=/usr/local/bin/glances -w -0 --time 30
Restart=on-abort

[Install]
WantedBy=multi-user.target" >  /etc/systemd/system/glances.service

systemctl enable glances.service
systemctl start glances.service

## Install R packages
# tidyverse, rvest, rgdal, raster, rasterVis, viridis, spatial.tools, doParallel, SDMTools, PythoninR
sudo su - \
-c "R -e \"install.packages('rvest', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('tidyverse', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('rgdal', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('raster', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('rasterVis', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('viridis', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('spatial.tools', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('doParallel', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('SDMTools', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('PythonInR', repos='https://cran.rstudio.com/')\""

# create swap space
fallocate -l 16G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Update and upgrade everything
apt-get update
apt-get -y --force-yes upgrade
