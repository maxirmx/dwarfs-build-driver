# Copyright (c) 2025 Maxim Samsonov.
#
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

def_ext_prj_t(NLOHMANN_JSON "3.11.3" "0d8ef5af7f9794e3263480193c491549b2ba6cc74bb018906202ada498a79406")

message(STATUS "Collecting nlohmann_json - " v${NLOHMANN_JSON_VER})

set(CMAKE_ARGUMENTS -DCMAKE_INSTALL_PREFIX=${DEPS}
                    -DJSON_BuildTests=OFF
                    -DJSON_MultipleHeaders=ON
)

ExternalProject_Add(${NLOHMANN_JSON_PRJ}
  PREFIX "${DEPS}"
  URL https://github.com/nlohmann/json/archive/refs/tags/v${NLOHMANN_JSON_VER}.tar.gz
  URL_HASH SHA256=${NLOHMANN_JSON_HASH}
  DOWNLOAD_NO_PROGRESS true
  UPDATE_COMMAND ""
  CMAKE_ARGS ${CMAKE_ARGUMENTS}
  SOURCE_DIR ${NLOHMANN_JSON_SOURCE_DIR}
  BINARY_DIR ${NLOHMANN_JSON_BINARY_DIR}
)
