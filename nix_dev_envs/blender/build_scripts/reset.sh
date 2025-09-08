#!/usr/bin/env bash

[ -e build.ninja ] && [ -e rules.ninja ] && ninja clean
rm -rf CMakeCache.txt CMakeFiles intern extern lib release source Testing tests build.ninja rules.ninja cmake_install.cmake CPackConfig.cmake CPackSourceConfig.cmake CTestTestfile.cmake install_manifest.txt bin/lib bin/tests Makefile compile_commands.json
rm -rf bin

