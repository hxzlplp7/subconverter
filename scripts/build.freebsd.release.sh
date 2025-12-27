#!/bin/bash
set -xe

# FreeBSD (Serv00) 编译脚本
# 在 FreeBSD 环境或使用 cross-compilation 时使用

# 安装依赖
pkg install -y git cmake ninja pcre2 curl rapidjson libyaml-cpp toml11

# 设置编译目录
mkdir -p build && cd build

# 使用 CMake 配置
cmake .. -G Ninja \
    -DCMAKE_BUILD_TYPE=Release

# 编译
ninja -j$(sysctl -n hw.ncpu)

cd ..

# 创建发布目录
mkdir -p subconverter
cp build/subconverter subconverter/
cp -r base/* subconverter/

echo "FreeBSD 编译完成!"
