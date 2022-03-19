
Download a few packages via

    ./bin/apt-repo-custom-source-download-and-create-repo.sh -f /home/han/cicd/debian-repo-mini-mirror/config/debian-client-packages.txt  -s /home/han/cicd/debian-repo-mini-mirror/config/debian.sources.list  -r repos/debian-workstation/2022-03-19/

Download several packages from a file 

    ./bin/apt-repo-custom-source-download-and-create-repo.sh -f /home/han/cicd/debian-repo-mini-mirror/config/debian-client-packages.txt  -s /home/han/cicd/debian-repo-mini-mirror/config/debian.sources.list  -r repos/debian-workstation/2022-03-19/ -d
