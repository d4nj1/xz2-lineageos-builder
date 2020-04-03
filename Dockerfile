FROM ubuntu:18.04
MAINTAINER Daniel Christophis <code@devmind.org>

ARG UID=1024
ARG GID=1024

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get purge openjdk-* icedtea-* icedtea6-*
RUN apt-get install -y \
	openjdk-8-jdk \
	bison \
	g++-multilib \
	git \
	git-lfs \
	gperf \
	libxml2-utils \
	make \
	zlib1g-dev:i386 \
	zip \
	liblz4-tool \
	libncurses5 \
	libssl-dev \
	bc \
	flex \
	curl \
	python \
	python3

RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /bin/repo
RUN chmod a+x /bin/repo

RUN groupadd -r -g $GID developer
RUN useradd -r -m -s /bin/bash -g $GID -u $UID developer
USER developer
WORKDIR /home/developer

RUN git config --global user.name "LineageOS builder"
RUN git config --global user.email "code@devmind.org"
RUN git config --global color.ui false

COPY --chown=developer:developer entrypoint.sh /home/developer/entrypoint.sh
RUN chmod +x /home/developer/entrypoint.sh
ENTRYPOINT [ "/home/developer/entrypoint.sh" ]