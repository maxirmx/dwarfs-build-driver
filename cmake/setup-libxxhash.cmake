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

set(LIBXXHASH_COMMIT "b5694e436dc9fc1c5a0389ac46b446167075490a")
def_ext_prj_g(LIBXXHASH ${LIBXXHASH_COMMIT})

message(STATUS "Collecting libxxhash - at commit ${LIBXXHASH_COMMIT} at ${LIBXXHASH_SOURCE_DIR}")

set(__LIBXXHASH "${DEPS}/lib/libxxhash.a")

set(CMAKE_ARGUMENTS -DCMAKE_INSTALL_PREFIX=${DEPS}
                    -DXXHASH_BUILD_XXHSUM=OFF
                    -DBUILD_SHARED_LIBS=OFF
                    -DDISPATCH=OFF
                    -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
)

if(TEBAKO_BUILD_TARGET)
  list(APPEND CMAKE_ARGUMENTS  -DCMAKE_C_FLAGS=--target=${TEBAKO_BUILD_TARGET})
  list(APPEND CMAKE_ARGUMENTS  -DCMAKE_EXE_LINKER_FLAGS=--target=${TEBAKO_BUILD_TARGET})
  list(APPEND CMAKE_ARGUMENTS  -DCMAKE_SHARED_LINKER_FLAGS=--target=${TEBAKO_BUILD_TARGET})
endif(TEBAKO_BUILD_TARGET)

ExternalProject_Add(${LIBXXHASH_PRJ}
  PREFIX "${DEPS}"
  GIT_REPOSITORY "https://github.com/Cyan4973/xxHash.git"
  GIT_TAG ${LIBXXHASH_TAG}
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND cmake -S ${LIBXXHASH_SOURCE_DIR}/build/cmake -B ${LIBXXHASH_BINARY_DIR} ${CMAKE_ARGUMENTS}
  SOURCE_DIR ${LIBXXHASH_SOURCE_DIR}
  BINARY_DIR ${LIBXXHASH_BINARY_DIR}
  BUILD_BYPRODUCTS ${__LIBXXHASH}
)

add_library(_LIBXXHASH STATIC IMPORTED)
set_target_properties(_LIBXXHASH PROPERTIES IMPORTED_LOCATION  ${__LIBXXHASH})
add_dependencies(_LIBXXHASH ${LIBXXHASH_PRJ})
