#!/bin/bash

[ -d "/usr/local/ssl" ] && export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/ssl/lib/pkgconfig
[ -d "$WORKSPACE/ziplib-bin" ] && export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORKSPACE/ziplib-bin/lib64/pkgconfig

curl --silent --location https://github.com/php/php-src/archive/php-7.4.1.tar.gz | tar --extract --gzip --verbose
cd php-src-php-7*

# Build PECL extension ImageMagick statically
if [ ! -f "ext/imagick" ]; then
  cd ext
  pecl download imagick
  gzip --decompress < imagick-*.tgz | tar -xvf -
  rm imagick-*.tgz
  mv imagick-* imagick
  cd ..
fi

./buildconf --force
sed -i 's/export PKG_CONFIG_PATH="/export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/g' configure
./configure \
  --prefix=$WORKSPACE/php74-bin/ \
  --with-openssl \
  --enable-bcmath \
  --enable-calendar \
  --enable-exif \
  --enable-fpm \
  --enable-ftp \
  --enable-intl \
  --enable-mbstring \
  --disable-mbregex \
  --enable-soap \
  --enable-sockets \
  --enable-sysvsem \
  --enable-sysvshm \
  --enable-sysvmsg \
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
  --with-zip \
  --with-zlib
make install

# xml $xml reader and #writer
