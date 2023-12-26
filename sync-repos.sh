#!/bin/bash


cwd=$(pwd)
debian_custom_repo_bin_dir="${cwd}/../debian-custom-repo/bin"
debian_custom_repo_config_dir="${cwd}/"
debian_custom_repo_data_dir="/var/www/html/repo/"


${debian_custom_repo_bin_dir}/apt-repo-custom-source-download-and-create-repo.sh \
    -f ${debian_custom_repo_config_dir}/server-repos/debian-packages.txt \
    -s ${debian_custom_repo_config_dir}/server-repos/debian.sources.list \
    -r ${debian_custom_repo_data_dir}/devrepo/20231226 \
    -d -z
