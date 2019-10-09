#!/usr/bin/env bash
$(aws ecr get-login --no-include-email --region eu-west-2)
for docker in $(find ./ -name Dockerfile); do
  name=$(dirname $docker)
  echo ${name#./}
  (cd $name && docker build -t ${name#./} .)
  docker tag ${name#./}:latest 090107652998.dkr.ecr.eu-west-2.amazonaws.com/platform-builder/${name#./}:latest
  docker push 090107652998.dkr.ecr.eu-west-2.amazonaws.com/${name#./}:latest
done
