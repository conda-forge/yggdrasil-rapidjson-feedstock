#!/bin/sh
set -euo pipefail

Python_INCLUDE_DIR="$(python -c 'import sysconfig; print(sysconfig.get_path("include"))')"
Python_NumPy_INCLUDE_DIR="$(python -c 'import numpy; print(numpy.get_include())')"

cmake -B build -S ${SRC_DIR} \
      -G "Ninja" \
      -D YGGDRASIL_RAPIDJSON_HAS_STDSTRING:BOOL=ON \
      -D YGGDRASIL_RAPIDJSON_BUILD_TESTS:BOOL=OFF \
      -D YGGDRASIL_RAPIDJSON_BUILD_EXAMPLES:BOOL=OFF \
      -D YGGDRASIL_RAPIDJSON_BUILD_DOC:BOOL=OFF \
      -D Python3_EXECUTABLE:PATH=${PYTHON} \
      -D Python3_INCLUDE_DIR:PATH=${Python_INCLUDE_DIR} \
      -D Python3_NumPy_INCLUDE_DIR=${Python_NumPy_INCLUDE_DIR} \
      -D CMAKE_VERBOSE_MAKEFILE:BOOL=ON \
       ${CMAKE_ARGS}
cmake --build build -j${CPU_COUNT}
cmake --install build
