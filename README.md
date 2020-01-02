# PHP 7.4 AWS Lambda Layer

To build PHP 7.4 for use as a layer in AWS Lambda:

* Ensure docker is installed and that you are a member of the `docker` group.

```bash
git clone git@github.com:tagadvance/AWS-Lambda-PHP.git
cd AWS-Lambda-PHP
make # please note that this may take several minutes
ls -lah build/
```

##### Included Extensions:
* openssl
* bcmath
* calendar
* exif
* fpm
* ftp
* intl
* mbstring (with mbregex disabled)
* soap
* sockets
* sysvsem
* sysvshm
* sysvmsg
* bz2
* curl
* gettext
* gmp
* imagick
* mysqli
* openssl
* pdo-mysql
* xsl
* xmlrpc
* zip
* zlib

## Manual (no longer maintained)
[A guide to downloading and compiling PHP 7.4 for use as a layer in AWS Lambda.](MANUAL.md)
