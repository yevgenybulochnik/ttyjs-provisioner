#!/bin/bash

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
pip install weasyprint
pip install Wand
# Example wand import
# from wand.image import Image as WImage
# img = WImage(filename='hat.pdf')
# img
