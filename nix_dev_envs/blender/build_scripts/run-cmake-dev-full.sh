#!/usr/bin/env bash

cmake \
  -G Ninja \
  -U'CMAKE_CXX_*' -U'CMAKE_C_*' \
  -C cmake_bits/full.cmake \
  -C cmake_bits/dev.cmake \
  -C cmake_bits/use_ccache.cmake \
  -C cmake_bits/experimental.cmake \
  \
  -DCMAKE_INSTALL_PREFIX=../install_debug \
  ../blender
