# AWS-Lambda-PHP

A guide to downloading and compiling PHP 7.4 for use in AWS Lambda.

## Download and compile PHP 7.4 via Amazon Linux AMI

@see [AWS Lambda Custom Runtime for PHP: A Practical Example](https://aws.amazon.com/blogs/apn/aws-lambda-custom-runtime-for-php-a-practical-example/)

*I recommend using at least a `t3.small` or `t3a.small` EC2 instance type. Compilation time is greatly reduced and
avoids running out of memory. You may have to add swap to instances with <= 1GB RAM.*

###### Update and Install Dependencies
```bash
sudo yum update -y
sudo yum install autoconf gcc gcc-c++ -y
sudo yum install bzip2-devel gmp-devel libcurl-devel libicu-devel libxml2-devel libxslt-devel \
  re2c sqlite-devel -y
```

###### Download, Compile, and install Bison

PHP 7.4 requires Bison 3 or later while Amazon Linux comes with version 2.7.

Find the latest version of Bison @ [GNU Bison](http://ftp.gnu.org/gnu/bison/?C=M;O=D)

```bash
curl -sL http://ftp.gnu.org/gnu/bison/bison-3.5.tar.gz | tar -xvz
cd bison-3.*
./configure
make
sudo make install
# Confirm Bison was installed
bison --version
```

`cd ~`

###### Download, Compile, and install OpenSSL

Use the 'about' lambda function to get the current version used by AWS Lambda. As of 2019-12-22 it is `OpenSSL 1.0.2k-fips  26 Jan 2017`.

Use [OpenSSL Old Releases](https://www.openssl.org/source/old/) to find the correct release.

```bash
curl -sL https://www.openssl.org/source/old/1.0.2/openssl-1.0.2k.tar.gz | tar -xvz
cd openssl*
./config --prefix=$HOME/openssl-bin/
make
make install
# Confirm OpenSSL was installed and ensure version matches exactly!
~/openssl-bin/bin/openssl version

echo 'export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/openssl-bin/lib/pkgconfig' >> ~/.bash_profile; source ~/.bash_profile
```

`cd ~`

###### Download, Compile, and install libzip

Compile a compatible version of libzip which in turn requires a recent version of cmake.
`Requested 'libzip >= 0.11' but version of libzip is 0.10.1`
`CMake 3.0.2 or higher is required.  You are running version 2.8.12.2`

```bash
curl -sL https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2.tar.gz | tar -xvz
cd cmake-*
./bootstrap
make
sudo make install
```

`cd ~`

```bash
curl -sL https://libzip.org/download/libzip-1.5.2.tar.gz | tar -xvz
cd libzip-*
mkdir build
cd build
cmake .. -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=$HOME/ziplib-bin
make
make test
make install

echo 'export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/ziplib-bin/lib64/pkgconfig' >> ~/.bash_profile; source ~/.bash_profile
```

`cd ~`

##### PHP 7.4

Find the latest stable version of PHP @ [PHP Releases](https://github.com/php/php-src/releases).

```bash
curl -sL https://github.com/php/php-src/archive/php-7.4.1.tar.gz | tar -xvz
cd php-src-php-7*
./buildconf --force
./configure \
  --prefix=$HOME/php-74-bin/ \
  --with-openssl \
  --with-openssl-dir=$HOME/openssl-bin \
  --enable-bcmath \
  --enable-calendar \
  --enable-fpm \
  --enable-ftp \
  --enable-intl \
  --enable-mbstring \
  --disable-mbregex \
  --enable-soap \
  --enable-sockets \
  --with-bz2 \
  --with-curl \
  --with-gettext \
  --with-gmp \
  --with-mysqli \
  --with-openssl \
  --with-pdo-mysql \
  --with-xsl \
  --with-xmlrpc \
  --with-zip \
  --with-zlib
make install

# Confirm PHP
~/php-*-bin/bin/php --version
```

Example output:
```text
PHP 7.4.1 (cli) (built: Dec 22 2019 23:40:31) ( NTS )
Copyright (c) The PHP Group
Zend Engine v3.4.0, Copyright (c) Zend Technologies
```