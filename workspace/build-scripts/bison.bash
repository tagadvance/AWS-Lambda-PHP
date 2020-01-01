#!/bin/bash

curl --silent --location http://ftp.gnu.org/gnu/bison/bison-3.5.tar.gz | tar -xvz
cd bison-3.*
./configure
make
make install
