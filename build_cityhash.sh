#!/bin/sh

# 为 crystal lang 编译cityhash库。 / Compile the cityhash library for crystal lang.
#   源码 / source：https://github.com/syalon/bitshares-cityhash.git
# by syalon

# 1、克隆源代码 / clone source code
SOURCE_CLONE_DIR="cityhash"

rm -rf $SOURCE_CLONE_DIR
git clone https://github.com/syalon/bitshares-cityhash.git $SOURCE_CLONE_DIR && cd $SOURCE_CLONE_DIR

# 2、编译 / compile
./configure
make all
sudo make install   #   for dynamic linking

# 3、完成
echo "compile done. target dir: $SOURCE_CLONE_DIR, lib dir: $SOURCE_CLONE_DIR/src/.libs"
