#!/bin/bash

curl --silent --location https://libzip.org/download/libzip-1.5.2.tar.gz | tar --extract --gzip --verbose
cd libzip-*
mkdir build
cd build
cmake .. -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=$WORKSPACE/ziplib-bin
make
make test
make install
