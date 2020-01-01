#!/bin/bash

mkdir --parents $WORKSPACE/lambda/layers/php74-cli/bin/
cp $WORKSPACE/php74-bin/bin/php $WORKSPACE/lambda/layers/php74-cli/bin/

cd $WORKSPACE/lambda/layers/php74-cli
mkdir --parents $BUILD_DIR
zip --recurse-paths $BUILD_DIR/php74-cli-layer.zip bin bootstrap
