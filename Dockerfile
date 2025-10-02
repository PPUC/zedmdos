FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -y -o APT::Immediate-Configure=0 \
	build-essential \
	git \
	locales \
	file \
	wget \
	cpio \
	unzip \
	zip \
	rsync \
	bc \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Set locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
	locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Workaround host-tar configure error
ENV FORCE_UNSAFE_CONFIGURE 1

RUN mkdir -p /build
WORKDIR /build

CMD ["/bin/bash"]
