all: package-php74

build-essential:
	yum install --assumeyes autoconf gcc gcc-c++

install-dependencies:
	yum install --assumeyes bzip2-devel gmp-devel ImageMagick-devel libcurl-devel libicu-devel libxml2-devel libxslt-devel \
	  php-pear re2c sqlite-devel

bison: build-essential
	./build-scripts/bison.bash

openssl: build-essential
	./build-scripts/openssl.bash

libzip: build-essential
	yum remove --assumeyes cmake
	yum install --assumeyes cmake3
	ln -s /usr/bin/cmake3 /usr/bin/cmake
	./build-scripts/libzip.bash

php74: bison openssl libzip install-dependencies
	./build-scripts/php74.bash

package-php74: php74
	./build-scripts/package-php74.bash
