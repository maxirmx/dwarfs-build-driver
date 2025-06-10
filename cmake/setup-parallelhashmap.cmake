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

set(LIBPHMAP_VER "v2.0.0")
def_ext_prj_g(LIBPHMAP ${LIBPHMAP_VER})

message(STATUS "Collecting parallel hashmap - ${LIBPHMAP_VER} at ${LIBPHMAP_SOURCE_DIR}")

set(__LIBPHMAP "${DEPS}/lib/parallel-hashmap.a")

set(CMAKE_ARGUMENTS -DCMAKE_INSTALL_PREFIX=${DEPS}
                    -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
                    -DPHMAP_BUILD_EXAMPLES=OFF
                    -DPHMAP_BUILD_TESTS=OFF
)

if(TEBAKO_BUILD_TARGET)
  list(APPEND CMAKE_ARGUMENTS  -DCMAKE_C_FLAGS=--target=${TEBAKO_BUILD_TARGET})
  list(APPEND CMAKE_ARGUMENTS  -DCMAKE_EXE_LINKER_FLAGS=--target=${TEBAKO_BUILD_TARGET})
  list(APPEND CMAKE_ARGUMENTS  -DCMAKE_SHARED_LINKER_FLAGS=--target=${TEBAKO_BUILD_TARGET})
endif(TEBAKO_BUILD_TARGET)

ExternalProject_Add(${LIBPHMAP_PRJ}
  PREFIX "${DEPS}"
  GIT_REPOSITORY "https://github.com/greg7mdp/parallel-hashmap.git"
  GIT_TAG ${LIBPHMAP_TAG}
  UPDATE_COMMAND ""
  CMAKE_ARGS ${CMAKE_ARGUMENTS}
  SOURCE_DIR ${LIBPHMAP_SOURCE_DIR}
  BINARY_DIR ${LIBPHMAP_BINARY_DIR}
  BUILD_BYPRODUCTS ${__LIBPHMAP}
)

add_library(_LIBPHMAP STATIC IMPORTED)
set_target_properties(_LIBPHMAP PROPERTIES IMPORTED_LOCATION  ${__LIBPHMAP})
add_dependencies(_LIBPHMAP ${LIBPHMAP_PRJ})
