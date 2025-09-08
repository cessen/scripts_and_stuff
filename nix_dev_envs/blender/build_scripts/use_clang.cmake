set(WITH_CLANG                   ON CACHE BOOL "" FORCE)

# Right now OpenMP isn't configured correctly for clang.
# TODO: re-enable this once that gets fixed in Blender's
# cmake config.
set(WITH_OPENMP                  OFF CACHE BOOL "" FORCE)
