#!/usr/bin/env bash

cmake \
  -G Ninja \
  -U'CMAKE_CXX_*' -U'CMAKE_C_*' \
  -C lean.cmake \
  -C dev.cmake \
  -C use_clang.cmake \
  -C use_ccache.cmake \
  \
  -DCMAKE_INSTALL_PREFIX=../install_debug_clang \
  ../blender
