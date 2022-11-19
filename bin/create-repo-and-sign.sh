#!/bin/bash

rm -rf Packages Packages.gz Release Release.gpg InRelease

apt-ftparchive --arch amd64 packages amd64 > Packages
gzip -k -f Packages
apt-ftparchive release . > Release
gpg  -abs -o Release.gpg Release
gpg --clearsign -o InRelease Release
