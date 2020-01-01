all: clean build package

clean:
	-rm --recursive --force build/

	-docker ps --all | grep "tagadvance/aws-lambda-php" | awk '{print $$1 }' | xargs docker rm
	-docker images --all | grep "tagadvance/aws-lambda-php" | awk '{print $$3}' | xargs docker rmi

clobber: clean
	-docker images --all | grep "lambci/lambda" | awk '{print $$3}' | xargs docker rmi

build:
	docker build --tag tagadvance/aws-lambda-php:1.0 .

package:
	docker run --name aws-lambda-php --volume `pwd`/build:/root/build --rm tagadvance/aws-lambda-php:1.0

debug:
	docker run --name aws-lambda-php --interactive --tty --volume `pwd`/build:/root/build --entrypoint=/bin/bash tagadvance/aws-lambda-php:1.0

