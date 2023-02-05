FROM debian:bullseye

ENV OPENWRT_REPO=/home/openwrt/openwrt
ENV PATCHES=/patches
ENV CONFIG=/config
ENV VERBOSE="false"

## Install dependencies
RUN apt-get update
RUN apt-get install -y sudo build-essential clang flex g++ gawk gettext file git \
    libncurses5-dev libssl-dev nano python3-distutils rsync unzip zlib1g-dev wget
RUN apt-get clean

# Add openwrt user
RUN useradd -m openwrt --shell /bin/bash && \
    echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt

COPY firmware-builder.sh /bin/
RUN chmod +x /bin/firmware-builder.sh

USER openwrt
WORKDIR /home/openwrt

CMD ["/bin/firmware-builder.sh"]
