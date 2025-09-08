#!/bin/bash

cmake \
  -G Ninja \
  -U'CMAKE_CXX_*' -U'CMAKE_C_*' \
  -C cmake_bits/lean.cmake \
  -C cmake_bits/dev.cmake \
  -C cmake_bits/use_ccache.cmake \
  \
  -DCMAKE_INSTALL_PREFIX=../install_debug \
  ../blender
