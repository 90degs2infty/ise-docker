FROM ubuntu:14.04

# Locale - make sure en_US.UTF-8 is available and the default locale
RUN locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \

# Xilinx ISE's dependencies
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    libfontconfig1 \
    libfreetype6 \
    libglib2.0-0 \
    libsm6 \
    # libx11-dev \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove --purge \
    && apt-get clean

# Installation utilities
# expect is required by the setup script
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    expect \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove --purge \
    && apt-get clean

# Pull in ISE installer
COPY xilinx-installer/Xilinx_ISE_DS_14.7_1015_1-1.tar \
    xilinx-installer/Xilinx_ISE_DS_14.7_1015_1-3.zip.xz \
    xilinx-installer/Xilinx_ISE_DS_14.7_1015_1-2.zip.xz \
    xilinx-installer/Xilinx_ISE_DS_14.7_1015_1-4.zip.xz \
    /tmp/

# Pull in helper scripts
COPY src/xilinx-ise-install.config /tmp/install/config
COPY src/install.exp /tmp/install.exp

# Install ISE
WORKDIR /tmp/install
RUN tar -xvf /tmp/Xilinx_ISE_DS_14.7_1015_1-1.tar \
    && TERM=xterm /tmp/install.exp \
    && echo -e "\n# Source xilinx settings\nsource /opt/Xilinx/14.7/ISE_DS/settings64.sh\n" >> /root/.bashrc \
    && rm -rf /tmp/* \
    && mkdir -p /root/.Xilinx

# Basic dev tools and utilities
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    git \
    # usbutils \
    vim \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove --purge \
    && apt-get clean

WORKDIR /workspace
CMD [ "bash" ]
