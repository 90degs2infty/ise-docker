# xilinx-ise

Xilinx ISE WebPACK 14.7 shipped in an OCI-compliant container.

## Getting started

In the following `$repo` refers to this repository's root directory.

### Prerequisites

- `buildah`\
  To build the container image, the helper scripts shipped under `tools` rely on `buildah`.
  Version `1.23.1` is known to work - other versions may work, too.

  This repository used to use `docker` - so it should be doable using `docker`, too.
  Feel free to try and adapt the scripts accordingly.
- `podman`\
  To run the eventual container image, the helper scripts shipped under `tools` rely on `podman`.
  Version `3.4.4` is known to work - other versions may work, too.

  This repository used to use `docker` - so it should be doable using `docker`, too.
  If `podman` is not installed, `docker` will be tried as a fallback.
- `Xilinx ISE` installer files\
  Due to licensing, the installer files are not shipped alongside this repository.
  Instead, please head over to [xilinx.com](https://www.xilinx.com/downloadNav/vivado-design-tools/archive-ise.html) and download the necessary files.
  You will need:

  - [Windows 7/XP/Server and Linux - Split Installer Base Image - File 1/4](https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_ISE_DS_14.7_1015_1-1.tar)
  - [Windows 7/XP/Server and Linux Install Data A - File 2/4](https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_ISE_DS_14.7_1015_1-2.zip.xz)
  - [Windows 7/XP/Server and Linux Install Data B - File 3/4](https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_ISE_DS_14.7_1015_1-3.zip.xz)
  - [ Windows 7/XP/Server and Linux Install Data C - File 4/4](https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_ISE_DS_14.7_1015_1-4.zip.xz)

  See [`context/src/sha256sums.txt`](context/src/sha256sums.txt) for their respective checksums.
- `Xilinx` license\
  Parts of the ISE suite require a license.
  You can obtain a free one at [xilinx.com](https://www.xilinx.com/support/licensing_solution_center.html).

### Building the image

Find a turn-key build script in [`tools/build.sh`](tools/build.sh).
The script builds the container described in [`context/Dockerfile`](context/Dockerfile) and tags it `xilinx-ise`.

First, copy all four installer files into `$repo/context/xilinx-installer`.
Note: you really have to copy the files.
Symlinking them via `ln -s` does not suffice!

Then issue:

```console
> cd $repo
> ./tools/build.sh
```

This will install the Xilinx ISE WebPACK suite inside the container.
The installers config is located at [`context/src/xilinx-ise-install.config`](context/src/xilinx-ise-install.config).

### Executing a containerized command

Find a turn-key runner script in [`tools/xilinx.sh`](tools/xilinx.sh).

The runner script eases the process of passing the license and the project directory into the container as well as forwarding GUI output (if any) from the container back to the host.
Feel free to adapt the eventual call to `podman run` if it does not fit your needs.

To get a basic help text, issue:

```console
> cd $repo
> ./tools/xilinx.sh -h
```

To execute some command inside the container, issue:

```console
> cd $repo
> ./tools/xilinx.sh -l /path/to/license -p /path/to/project/dir -- ise-command
```

Note that `/path/to/project/dir` has to obey some rules due to the way `podman` mounts host-directories inside containers.
For details, see the above help text.

To get the list of available ISE commands, do not specify any ISE command at all:

```console
> cd $repo
> ./tools/xilinx.sh -l /path/to/license -p /path/to/project/dir --
```

## What's in the box?

The image is based on `ubuntu:14.04`.

On top of that, the necessary packages required by `Xilinx ISE` are installed.
This leaves us with:

```console
> apt list --installed
Listing... Done
adduser/now 3.113+nmu3ubuntu3 all [installed,local]
apt/now 1.0.1ubuntu2.24 amd64 [installed,local]
apt-transport-https/now 1.0.1ubuntu2.24 amd64 [installed,local]
apt-utils/now 1.0.1ubuntu2.24 amd64 [installed,local]
base-files/now 7.2ubuntu5.6 amd64 [installed,local]
base-passwd/now 3.5.33 amd64 [installed,local]
bash/now 4.3-7ubuntu1.7 amd64 [installed,local]
bsdutils/now 1:2.20.1-5.1ubuntu20.9 amd64 [installed,local]
busybox-initramfs/now 1:1.21.0-1ubuntu1.4 amd64 [installed,local]
bzip2/now 1.0.6-5 amd64 [installed,local]
ca-certificates/now 20170717~14.04.2 all [installed,local]
console-setup/now 1.70ubuntu8 all [installed,local]
coreutils/now 8.21-1ubuntu5.4 amd64 [installed,local]
cpio/now 2.11+dfsg-1ubuntu1.2 amd64 [installed,local]
cron/now 3.0pl1-124ubuntu2 amd64 [installed,local]
dash/now 0.5.7-4ubuntu1 amd64 [installed,local]
debconf/now 1.5.51ubuntu2 all [installed,local]
debconf-i18n/now 1.5.51ubuntu2 all [installed,local]
debianutils/now 4.4 amd64 [installed,local]
dh-python/now 1.20140128-1ubuntu8.2 all [installed,local]
diffutils/now 1:3.3-1 amd64 [installed,local]
dmsetup/now 2:1.02.77-6ubuntu2 amd64 [installed,local]
dpkg/now 1.17.5ubuntu5.8 amd64 [installed,local]
e2fslibs/now 1.42.9-3ubuntu1.3 amd64 [installed,local]
e2fsprogs/now 1.42.9-3ubuntu1.3 amd64 [installed,local]
eject/now 2.1.5+deb1+cvs20081104-13.1ubuntu0.14.04.1 amd64 [installed,local]
expect/now 5.45-5ubuntu1 amd64 [installed,local]
file/now 1:5.14-2ubuntu3.4 amd64 [installed,local]
findutils/now 4.4.2-7 amd64 [installed,local]
fontconfig-config/now 2.11.0-0ubuntu4 all [installed,local]
fonts-dejavu-core/now 2.34-1ubuntu1 all [installed,local]
gcc-4.8-base/now 4.8.4-2ubuntu1~14.04.4 amd64 [installed,local]
gcc-4.9-base/now 4.9.3-0ubuntu4 amd64 [installed,local]
gnupg/now 1.4.16-1ubuntu2.6 amd64 [installed,local]
gpgv/now 1.4.16-1ubuntu2.6 amd64 [installed,local]
grep/now 2.16-1 amd64 [installed,local]
gzip/now 1.6-3ubuntu1 amd64 [installed,local]
hostname/now 3.15ubuntu1 amd64 [installed,local]
ifupdown/now 0.7.47.2ubuntu4.5 amd64 [installed,local]
init-system-helpers/now 1.14ubuntu1 all [installed,local]
initramfs-tools/now 0.103ubuntu4.11 all [installed,local]
initramfs-tools-bin/now 0.103ubuntu4.11 amd64 [installed,local]
initscripts/now 2.88dsf-41ubuntu6.3 amd64 [installed,local]
insserv/now 1.14.0-5ubuntu2 amd64 [installed,local]
iproute2/now 3.12.0-2ubuntu1.2 amd64 [installed,local]
iputils-ping/now 3:20121221-4ubuntu1.1 amd64 [installed,local]
isc-dhcp-client/now 4.2.4-7ubuntu12.13 amd64 [installed,local]
isc-dhcp-common/now 4.2.4-7ubuntu12.13 amd64 [installed,local]
kbd/now 1.15.5-1ubuntu1 amd64 [installed,local]
keyboard-configuration/now 1.70ubuntu8 all [installed,local]
klibc-utils/now 2.0.3-0ubuntu1.14.04.3 amd64 [installed,local]
kmod/now 15-0ubuntu7 amd64 [installed,local]
krb5-locales/now 1.12+dfsg-2ubuntu5.4 all [installed,local]
less/now 458-2 amd64 [installed,local]
libacl1/now 2.2.52-1 amd64 [installed,local]
libapt-inst1.5/now 1.0.1ubuntu2.24 amd64 [installed,local]
libapt-pkg4.12/now 1.0.1ubuntu2.24 amd64 [installed,local]
libarchive-extract-perl/now 0.70-1 all [installed,local]
libasn1-8-heimdal/now 1.6~git20131207+dfsg-1ubuntu1.2 amd64 [installed,local]
libattr1/now 1:2.4.47-1ubuntu1 amd64 [installed,local]
libaudit-common/now 1:2.3.2-2ubuntu1 all [installed,local]
libaudit1/now 1:2.3.2-2ubuntu1 amd64 [installed,local]
libblkid1/now 2.20.1-5.1ubuntu20.9 amd64 [installed,local]
libbsd0/now 0.6.0-2ubuntu1 amd64 [installed,local]
libbz2-1.0/now 1.0.6-5 amd64 [installed,local]
libc-bin/now 2.19-0ubuntu6.15 amd64 [installed,local]
libc6/now 2.19-0ubuntu6.15 amd64 [installed,local]
libcap2/now 1:2.24-0ubuntu2 amd64 [installed,local]
libcap2-bin/now 1:2.24-0ubuntu2 amd64 [installed,local]
libcgmanager0/now 0.24-0ubuntu7.5 amd64 [installed,local]
libcomerr2/now 1.42.9-3ubuntu1.3 amd64 [installed,local]
libcurl3-gnutls/now 7.35.0-1ubuntu2.20 amd64 [installed,local]
libdb5.3/now 5.3.28-3ubuntu3.1 amd64 [installed,local]
libdbus-1-3/now 1.6.18-0ubuntu4.5 amd64 [installed,local]
libdebconfclient0/now 0.187ubuntu1 amd64 [installed,local]
libdevmapper1.02.1/now 2:1.02.77-6ubuntu2 amd64 [installed,local]
libdrm2/now 2.4.67-1ubuntu0.14.04.2 amd64 [installed,local]
libestr0/now 0.1.9-0ubuntu2 amd64 [installed,local]
libexpat1/now 2.1.0-4ubuntu1.4 amd64 [installed,local]
libffi6/now 3.1~rc1+r3.0.13-12ubuntu0.2 amd64 [installed,local]
libfontconfig1/now 2.11.0-0ubuntu4 amd64 [installed,local]
libfreetype6/now 2.5.2-1ubuntu2 amd64 [installed,local]
libfribidi0/now 0.19.6-1 amd64 [installed,local]
libgcc1/now 1:4.9.3-0ubuntu4 amd64 [installed,local]
libgcrypt11/now 1.5.3-2ubuntu4.6 amd64 [installed,local]
libgdbm3/now 1.8.3-12build1 amd64 [installed,local]
libglib2.0-0/now 2.40.0-2 amd64 [installed,local]
libgnutls-openssl27/now 2.12.23-12ubuntu2.8 amd64 [installed,local]
libgnutls26/now 2.12.23-12ubuntu2.8 amd64 [installed,local]
libgpg-error0/now 1.12-0.2ubuntu1 amd64 [installed,local]
libgssapi-krb5-2/now 1.12+dfsg-2ubuntu5.4 amd64 [installed,local]
libgssapi3-heimdal/now 1.6~git20131207+dfsg-1ubuntu1.2 amd64 [installed,local]
libhcrypto4-heimdal/now 1.6~git20131207+dfsg-1ubuntu1.2 amd64 [installed,local]
libheimbase1-heimdal/now 1.6~git20131207+dfsg-1ubuntu1.2 amd64 [installed,local]
libheimntlm0-heimdal/now 1.6~git20131207+dfsg-1ubuntu1.2 amd64 [installed,local]
libhx509-5-heimdal/now 1.6~git20131207+dfsg-1ubuntu1.2 amd64 [installed,local]
libice6/now 2:1.0.8-2 amd64 [installed,local]
libidn11/now 1.28-1ubuntu2.2 amd64 [installed,local]
libjson-c2/now 0.11-3ubuntu1.2 amd64 [installed,local]
libjson0/now 0.11-3ubuntu1.2 amd64 [installed,local]
libk5crypto3/now 1.12+dfsg-2ubuntu5.4 amd64 [installed,local]
libkeyutils1/now 1.5.6-1 amd64 [installed,local]
libklibc/now 2.0.3-0ubuntu1.14.04.3 amd64 [installed,local]
libkmod2/now 15-0ubuntu7 amd64 [installed,local]
libkrb5-26-heimdal/now 1.6~git20131207+dfsg-1ubuntu1.2 amd64 [installed,local]
libkrb5-3/now 1.12+dfsg-2ubuntu5.4 amd64 [installed,local]
libkrb5support0/now 1.12+dfsg-2ubuntu5.4 amd64 [installed,local]
libldap-2.4-2/now 2.4.31-1+nmu2ubuntu8.5 amd64 [installed,local]
liblocale-gettext-perl/now 1.05-7build3 amd64 [installed,local]
liblockfile-bin/now 1.09-6ubuntu1 amd64 [installed,local]
liblockfile1/now 1.09-6ubuntu1 amd64 [installed,local]
liblog-message-simple-perl/now 0.10-1 all [installed,local]
liblzma5/now 5.1.1alpha+20120614-2ubuntu2 amd64 [installed,local]
libmagic1/now 1:5.14-2ubuntu3.4 amd64 [installed,local]
libmodule-pluggable-perl/now 5.1-1 all [installed,local]
libmount1/now 2.20.1-5.1ubuntu20.9 amd64 [installed,local]
libmpdec2/now 2.4.0-6 amd64 [installed,local]
libncurses5/now 5.9+20140118-1ubuntu1 amd64 [installed,local]
libncursesw5/now 5.9+20140118-1ubuntu1 amd64 [installed,local]
libnewt0.52/now 0.52.15-2ubuntu5 amd64 [installed,local]
libnih-dbus1/now 1.0.3-4ubuntu25 amd64 [installed,local]
libnih1/now 1.0.3-4ubuntu25 amd64 [installed,local]
libp11-kit0/now 0.20.2-2ubuntu2 amd64 [installed,local]
libpam-cap/now 1:2.24-0ubuntu2 amd64 [installed,local]
libpam-modules/now 1.1.8-1ubuntu2.2 amd64 [installed,local]
libpam-modules-bin/now 1.1.8-1ubuntu2.2 amd64 [installed,local]
libpam-runtime/now 1.1.8-1ubuntu2.2 all [installed,local]
libpam0g/now 1.1.8-1ubuntu2.2 amd64 [installed,local]
libpcre3/now 1:8.31-2ubuntu2.3 amd64 [installed,local]
libplymouth2/now 0.8.8-0ubuntu17.2 amd64 [installed,local]
libpng12-0/now 1.2.50-1ubuntu2.14.04.3 amd64 [installed,local]
libpod-latex-perl/now 0.61-1 all [installed,local]
libpopt0/now 1.16-8ubuntu1 amd64 [installed,local]
libprocps3/now 1:3.3.9-1ubuntu2.3 amd64 [installed,local]
libpython3-stdlib/now 3.4.0-0ubuntu2 amd64 [installed,local]
libpython3.4-minimal/now 3.4.3-1ubuntu1~14.04.7 amd64 [installed,local]
libpython3.4-stdlib/now 3.4.3-1ubuntu1~14.04.7 amd64 [installed,local]
libreadline6/now 6.3-4ubuntu2 amd64 [installed,local]
libroken18-heimdal/now 1.6~git20131207+dfsg-1ubuntu1.2 amd64 [installed,local]
librtmp0/now 2.4+20121230.gitdf6c518-1ubuntu0.1 amd64 [installed,local]
libsasl2-2/now 2.1.25.dfsg1-17build1 amd64 [installed,local]
libsasl2-modules/now 2.1.25.dfsg1-17build1 amd64 [installed,local]
libsasl2-modules-db/now 2.1.25.dfsg1-17build1 amd64 [installed,local]
libselinux1/now 2.2.2-1ubuntu0.1 amd64 [installed,local]
libsemanage-common/now 2.2-1 all [installed,local]
libsemanage1/now 2.2-1 amd64 [installed,local]
libsepol1/now 2.2-1ubuntu0.1 amd64 [installed,local]
libslang2/now 2.2.4-15ubuntu1 amd64 [installed,local]
libsm6/now 2:1.2.1-2 amd64 [installed,local]
libsqlite3-0/now 3.8.2-1ubuntu2.2 amd64 [installed,local]
libss2/now 1.42.9-3ubuntu1.3 amd64 [installed,local]
libssl1.0.0/now 1.0.1f-1ubuntu2.27 amd64 [installed,local]
libstdc++6/now 4.8.4-2ubuntu1~14.04.4 amd64 [installed,local]
libtasn1-6/now 3.4-3ubuntu0.6 amd64 [installed,local]
libtcl8.6/now 8.6.1-4ubuntu1 amd64 [installed,local]
libterm-ui-perl/now 0.42-1 all [installed,local]
libtext-charwidth-perl/now 0.04-7build3 amd64 [installed,local]
libtext-iconv-perl/now 1.7-5build2 amd64 [installed,local]
libtext-soundex-perl/now 3.4-1build1 amd64 [installed,local]
libtext-wrapi18n-perl/now 0.06-7 all [installed,local]
libtinfo5/now 5.9+20140118-1ubuntu1 amd64 [installed,local]
libudev1/now 204-5ubuntu20.31 amd64 [installed,local]
libusb-0.1-4/now 2:0.1.12-23.3ubuntu1 amd64 [installed,local]
libustr-1.0-1/now 1.0.4-3ubuntu2 amd64 [installed,local]
libuuid1/now 2.20.1-5.1ubuntu20.9 amd64 [installed,local]
libwind0-heimdal/now 1.6~git20131207+dfsg-1ubuntu1.2 amd64 [installed,local]
libx11-6/now 2:1.6.2-1ubuntu2 amd64 [installed,local]
libx11-data/now 2:1.6.2-1ubuntu2 all [installed,local]
libxau6/now 1:1.0.8-1 amd64 [installed,local]
libxcb1/now 1.10-2ubuntu1 amd64 [installed,local]
libxdmcp6/now 1:1.1.1-1 amd64 [installed,local]
libxext6/now 2:1.3.2-1 amd64 [installed,local]
libxi6/now 2:1.7.1.901-1ubuntu1 amd64 [installed,local]
libxrandr2/now 2:1.4.2-1 amd64 [installed,local]
libxrender1/now 1:0.9.8-1 amd64 [installed,local]
libyaml-0-2/now 0.1.4-3ubuntu3.1 amd64 [installed,local]
locales/now 2.13+git20120306-12.1 all [installed,local]
lockfile-progs/now 0.1.17 amd64 [installed,local]
login/now 1:4.1.5.1-1ubuntu9.5 amd64 [installed,local]
logrotate/now 3.8.7-1ubuntu1.2 amd64 [installed,local]
lsb-base/now 4.1+Debian11ubuntu6.2 all [installed,local]
lsb-release/now 4.1+Debian11ubuntu6.2 all [installed,local]
makedev/now 2.3.1-93ubuntu2~ubuntu14.04.1 all [installed,local]
mawk/now 1.3.3-17ubuntu2 amd64 [installed,local]
mime-support/now 3.54ubuntu1.1 all [installed,local]
module-init-tools/now 15-0ubuntu7 all [installed,local]
mount/now 2.20.1-5.1ubuntu20.9 amd64 [installed,local]
mountall/now 2.53ubuntu1 amd64 [installed,local]
multiarch-support/now 2.19-0ubuntu6.15 amd64 [installed,local]
ncurses-base/now 5.9+20140118-1ubuntu1 all [installed,local]
ncurses-bin/now 5.9+20140118-1ubuntu1 amd64 [installed,local]
net-tools/now 1.60-25ubuntu2.1 amd64 [installed,local]
netbase/now 5.2 all [installed,local]
netcat-openbsd/now 1.105-7ubuntu1 amd64 [installed,local]
ntpdate/now 1:4.2.6.p5+dfsg-3ubuntu2.14.04.13 amd64 [installed,local]
openssl/now 1.0.1f-1ubuntu2.27 amd64 [installed,local]
passwd/now 1:4.1.5.1-1ubuntu9.5 amd64 [installed,local]
perl/now 5.18.2-2ubuntu1.7 amd64 [installed,local]
perl-base/now 5.18.2-2ubuntu1.7 amd64 [installed,local]
perl-modules/now 5.18.2-2ubuntu1.7 all [installed,local]
plymouth/now 0.8.8-0ubuntu17.2 amd64 [installed,local]
procps/now 1:3.3.9-1ubuntu2.3 amd64 [installed,local]
python3/now 3.4.0-0ubuntu2 amd64 [installed,local]
python3-minimal/now 3.4.0-0ubuntu2 amd64 [installed,local]
python3-pkg-resources/now 3.3-1ubuntu2 all [installed,local]
python3-yaml/now 3.10-4ubuntu0.1 amd64 [installed,local]
python3.4/now 3.4.3-1ubuntu1~14.04.7 amd64 [installed,local]
python3.4-minimal/now 3.4.3-1ubuntu1~14.04.7 amd64 [installed,local]
readline-common/now 6.3-4ubuntu2 all [installed,local]
resolvconf/now 1.69ubuntu1.4 all [installed,local]
rsyslog/now 7.4.4-1ubuntu2.7 amd64 [installed,local]
sed/now 4.2.2-4ubuntu1 amd64 [installed,local]
sensible-utils/now 0.0.9ubuntu0.14.04.1 all [installed,local]
sudo/now 1.8.9p5-1ubuntu1.4 amd64 [installed,local]
sysv-rc/now 2.88dsf-41ubuntu6.3 all [installed,local]
sysvinit-utils/now 2.88dsf-41ubuntu6.3 amd64 [installed,local]
tar/now 1.27.1-1ubuntu0.1 amd64 [installed,local]
tzdata/now 2019a-0ubuntu0.14.04 all [installed,local]
ubuntu-advantage-tools/now 19.6~ubuntu14.04.3 amd64 [installed,local]
ubuntu-keyring/now 2012.05.19 all [installed,local]
ubuntu-minimal/now 1.325.1 amd64 [installed,local]
ucf/now 3.0027+nmu1 all [installed,local]
udev/now 204-5ubuntu20.31 amd64 [installed,local]
upstart/now 1.12.1-0ubuntu4.2 amd64 [installed,local]
ureadahead/now 0.100.0-16 amd64 [installed,local]
util-linux/now 2.20.1-5.1ubuntu20.9 amd64 [installed,local]
vim-common/now 2:7.4.052-1ubuntu3.1 amd64 [installed,local]
vim-tiny/now 2:7.4.052-1ubuntu3.1 amd64 [installed,local]
whiptail/now 0.52.15-2ubuntu5 amd64 [installed,local]
x11-common/now 1:7.7+1ubuntu8 all [installed,local]
xkb-data/now 2.10.1-1ubuntu1 all [installed,local]
zlib1g/now 1:1.2.8.dfsg-1ubuntu1.1 amd64 [installed,local]
```

Last but not least, the Xilinx ISE WebPACK suite is included.

## Notes

The image ships a custom entrypoint (the script available at [`context/src/entrypoint.sh`](context/src/entrypoint.sh)), which takes care of setting up all the ISE-required settings.
I.e. it `source`s the setting script located inside the container at `/opt/Xilinx/14.7/ISE_DS/settings64.sh`.
Since the image's purpose is to launch ISE commands, this is what the user expects to happen.

Unfortunately, above script skrews up parts of the container (e.g. containerized `apt` will fail afterwards due to `apt: /opt/Xilinx/14.7/ISE_DS/ISE/lib/lin64/libstdc++.so.6: version 'GLIBCXX_3.4.9' not found (required by apt)`).
If you ever happen to require access to the container _without_ the ISE-required settings applied, make sure to [overwrite the entrypoint](https://docs.podman.io/en/latest/markdown/podman-run.1.html#entrypoint-command-command-arg1) accordingly (e.g. using `--entrypoint=bash`).
