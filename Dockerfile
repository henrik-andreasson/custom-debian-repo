FROM debian:bookworm
#FROM docs-cs-customers

WORKDIR /build
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y \
    unzip  wget bash xorriso ruby ruby-rubygems apt-rdepends sudo apt-utils
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN gem install fpm

RUN mkdir -p /build

RUN mkdir -p        /build/bin
RUN mkdir -p        /build/config

COPY bin/*          /build/bin
COPY config/*      /build/config

ENTRYPOINT ["/build/bin/apt-repo-custom-source-download-and-create-repo.sh"]
