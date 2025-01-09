#!/bin/bash

docker build -t custom_debian_repo .

docker run --rm -it \
    --entrypoint /build/bin/apt-repo-custom-source-download-and-create-repo.sh \
    --mount type=bind,source=/opt/custom-debian-repo/config/,target=/build/config \
    --mount type=bind,source=/opt/custom-debian-repo/repos/,target=/build/repos \
    custom_debian_repo \
    -f config/debian-client-packages.txt  \
    -s config/debian.sources.list \
    -r repos/debian-workstation/2025-01-09/ \
    -d
