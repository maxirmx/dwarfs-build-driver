# Copyright (c) 2025 Maxim Samsonov.
# Copyright (c) 2024 [Ribose Inc](https://www.ribose.com).
# All rights reserved.
# This file is a part of tebako
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

set(LIBRANGEV3_VER "0.12.0")
def_ext_prj_g(LIBRANGEV3 ${LIBRANGEV3_VER})

message(STATUS "Collecting range-v3 - " v${LIBRANGEV3_VER} " at " ${LIBRANGEV3_SOURCE_DIR})

set(__LIBRANGEV3 "${DEPS}/lib/librange-v3.a")

set(CMAKE_ARGUMENTS -DCMAKE_INSTALL_PREFIX=${DEPS}
                    -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
                    -DRANGE_V3_TESTS=OFF
                    -DRANGE_V3_EXAMPLES=OFF
                    -DRANGE_V3_PERF=OFF
                    -DRANGE_V3_DOCS=OFF
                    -DCMAKE_BUILD_TYPE=Release
)

if(TEBAKO_BUILD_TARGET)
  list(APPEND CMAKE_ARGUMENTS  -DCMAKE_C_FLAGS=--target=${TEBAKO_BUILD_TARGET})
  list(APPEND CMAKE_ARGUMENTS  -DCMAKE_EXE_LINKER_FLAGS=--target=${TEBAKO_BUILD_TARGET})
  list(APPEND CMAKE_ARGUMENTS  -DCMAKE_SHARED_LINKER_FLAGS=--target=${TEBAKO_BUILD_TARGET})
endif(TEBAKO_BUILD_TARGET)

ExternalProject_Add(${LIBRANGEV3_PRJ}
  PREFIX "${DEPS}"
  GIT_REPOSITORY "https://github.com/ericniebler/range-v3.git"
  GIT_TAG ${LIBRANGEV3_TAG}
  UPDATE_COMMAND ""
  CMAKE_ARGS ${CMAKE_ARGUMENTS}
  SOURCE_DIR ${LIBRANGEV3_SOURCE_DIR}
  BINARY_DIR ${LIBRANGEV3_BINARY_DIR}
  BUILD_BYPRODUCTS ${__LIBRANGEV3}
)

add_library(_LIBRANGEV3 STATIC IMPORTED)
set_target_properties(_LIBRANGEV3 PROPERTIES IMPORTED_LOCATION  ${__LIBRANGEV3})
add_dependencies(_LIBRANGEV3 ${LIBRANGEV3_PRJ})
