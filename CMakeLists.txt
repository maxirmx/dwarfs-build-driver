# Copyright (c) 2025 Maxim Samsonov.
# All rights reserved.
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

cmake_minimum_required(VERSION 3.24.0)

# Enable CMAKE_MSVC_RUNTIME_LIBRARY
cmake_policy(SET CMP0091 NEW)

project(dwarfs-build-driver)

if (NOT DEPS)
  set(DEPS "${CMAKE_CURRENT_SOURCE_DIR}/deps")
  message(STATUS "Using local setting for DEPS folder: ${DEPS}")
  set(EXTERNAL_DEPS OFF)
else()
  message(STATUS "Using upstream setting for DEPS folder: ${DEPS}")
  set(EXTERNAL_DEPS ON)
endif()

set(GNU_BASH "bash")

set(DEPS_INCLUDE_DIR ${DEPS}/include)
set(DEPS_LIB_DIR ${DEPS}/lib)
set(DEPS_BIN_DIR ${DEPS}/bin)
set(DEPS_SBIN_DIR ${DEPS}/sbin)

include(ExternalProject)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(def-external-project)
include(setup-openssl-3)
include(setup-libarchive)
include(setup-libfmt)
include(setup-libxxhash)
include(setup-parallelhashmap)
include(setup-librange-v3)
include(setup-libhowardhinnantdate)
include(setup-libutfcpp)

def_ext_prj_g(DWARFS "v0.12.4")

ExternalProject_Add(${DWARFS_PRJ}
    PREFIX ${DEPS}
    GIT_REPOSITORY "https://github.com/mhx/dwarfs.git"
    GIT_TAG ${DWARFS_TAG}
    UPDATE_COMMAND ""
    SOURCE_DIR ${DWARFS_SOURCE_DIR}
    BINARY_DIR ${DWARFS_BINARY_DIR}
    CMAKE_ARGS -GNinja 
               -DCMAKE_INSTALL_PREFIX=${DEPS}
               -DCMAKE_PREFIX_PATH=${DEPS};/usr/local 
               -DWITH_TESTS=OFF
               -DWITH_LIBDWARFS=ON
               -DWITH_TOOLS=ON
               -DWITH_FUSE_DRIVER=OFF
               -DWITH_MAN_PAGES=OFF
               -DWITH_MAN_OPTION=OFF
               -DSTATIC_BUILD_DO_NOT_USE=OFF
               -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               ${OPENSSL_OPTION}
               ${EXTRA_OPTS}
)
