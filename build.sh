#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"
pwd

echo "build sftp docker image"
docker build --rm --force-rm -t 1000kit/sftp .


#end
