# Copyright (C) 2013-2016 JadeCore <https://www.jadecore.tk/>
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your
# option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

# set up output paths for executable binaries (.exe-files, and .dll-files on DLL-capable platforms)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Set build-directive (used in core to tell which buildtype we used)
add_definitions(-D_BUILD_DIRECTIVE=\\"${CMAKE_BUILD_TYPE}\\")

if(PLATFORM EQUAL 32)
  # Required on 32-bit systems to enable SSE2 (standard on x64)
  set(SSE_FLAGS "-msse2 -mfpmath=sse")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${SSE_FLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SSE_FLAGS}")
endif()
add_definitions(-DHAVE_SSE2 -D__SSE2__)
message(STATUS "GCC: SFMT enabled, SSE2 flags forced")

if( WITH_WARNINGS )
  set(WARNING_FLAGS "-W -Wall -Wextra -Winit-self -Winvalid-pch -Wfatal-errors")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${WARNING_FLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${WARNING_FLAGS} -Woverloaded-virtual")
  message(STATUS "GCC: All warnings enabled")
endif()

if( WITH_COREDEBUG )
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g3")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g3")
  message(STATUS "GCC: Debug-flags set (-g3)")
endif()
