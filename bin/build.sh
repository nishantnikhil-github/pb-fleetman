#!/usr/bin/env bash
for docker in $(find ./ -name Dockerfile); do
  name=$(dirname $docker)
  echo ${name#./}
  (cd $name && docker build -t ${name#./} .)
  aws ecr create-repository --repository-name ${name#./}
  $(aws ecr get-login --no-include-email --region eu-west-2)
  docker tag ${name#./}:latest 090107652998.dkr.ecr.eu-west-2.amazonaws.com/${name#./}:latest
  docker push 090107652998.dkr.ecr.eu-west-2.amazonaws.com/${name#./}:latest
done
