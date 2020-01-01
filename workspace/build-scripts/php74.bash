#!/bin/bash

[ -d "/usr/local/ssl" ] && export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/ssl/lib/pkgconfig

curl --silent --location https://github.com/php/php-src/archive/php-7.4.1.tar.gz | tar -xvz
cd php-src-php-7*

# Build PECL extension ImageMagick statically
cd ext
pecl download imagick
gzip --decompress < imagick-*.tgz | tar -xvf -
rm imagick-*.tgz
mv imagick-* imagick
cd ..

./buildconf --force
./configure \
  --prefix=$WORKSPACE/php74-bin/ \
  --with-openssl \
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
  --with-imagick \
  --with-mysqli \
  --with-openssl \
  --with-pdo-mysql \
  --with-xsl \
  --with-xmlrpc \
  --with-zlib
make install
