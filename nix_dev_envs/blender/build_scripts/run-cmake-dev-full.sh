#!/bin/bash

cmake \
  -G Ninja \
  -U'CMAKE_CXX_*' -U'CMAKE_C_*' \
  -C full.cmake \
  -C dev.cmake \
  -C use_ccache.cmake \
  \
  -DCMAKE_INSTALL_PREFIX=../install_debug \
  ../blender
