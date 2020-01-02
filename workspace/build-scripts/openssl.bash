#!/bin/bash

curl --silent --location https://www.openssl.org/source/old/1.0.2/openssl-1.0.2k.tar.gz | tar --extract --gzip --verbose
cd openssl*
./config
make
make install
