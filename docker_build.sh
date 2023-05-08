docker run -it --rm debian:bullseye bash

useradd -m -s /bin/bash huengchi # 不能以root编译
su -l huengchi

export http_proxy=http://10.249.42.241:41122
export https_proxy=http://10.249.42.241:41122

apt update -y
apt full-upgrade -y
apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev \
libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz \
mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pyelftools \
libpython3-dev qemu-utils rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip \
vim wget xmlto xxd zlib1g-dev


git clone https://github.com/openwrt/openwrt.git -b openwrt-22.03 --single-branch

# Update the feeds
./scripts/feeds update -a
./scripts/feeds install -a

make menuconfig

make download -j8 V=s

#检查文件完整性
find dl -size -1024c -exec ls -l {} \;

#开始编译
make -j96 V=s