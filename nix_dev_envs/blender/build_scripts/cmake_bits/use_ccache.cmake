# Use Ccache for faster rebuilds.
set(CMAKE_C_COMPILER_LAUNCHER    "ccache" CACHE STRING "" FORCE)
set(CMAKE_CXX_COMPILER_LAUNCHER  "ccache" CACHE STRING "" FORCE)
