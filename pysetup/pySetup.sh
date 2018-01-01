#!/bin/bash

mkdir ~/pyEnvs
cd ~/pyEnvs

# Python3.6 setup
sudo apt install -y libsqlite3-dev
wget 'https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz'
tar -xf Python-3.6.3.tgz
cd Python-3.6.3

./configure
make
sudo make altinstall

cd ~/pyEnvs
python3.6 -m venv py3.6

# WeasyPrint dependencies
sudo apt install -y \
    build-essential \
    python3-dev \
    python3-pip \
    python3-cffi \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0.0 \
    libgdk-pixbuf2.0-0 \
    libffi-dev \
    shared-mime-info

# Wand-py dependencies
sudo apt install -y libmagickwand-dev

# Pip installs
source ~/pyEnvs/py3.6/bin/activate
pip install weasyprint
pip install Wand
pip install jupyter
pip install matplotlib
pip install pandas
pip install xlsxwriter
# Example wand import
# from wand.image import Image as WImage
# img = WImage(filename='hat.pdf')
# img

# clean up
sudo rm -rf ~/pyEnvs/Python-3.6.3*
sudo rm -rf ~/pysetup/
