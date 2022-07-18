cmake_minimum_required(VERSION 3.17)

project(RPZOO CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

# Keep it above `set(CXX_FLAGS ...`
include(external_grpc.cmake)

set(CMAKE_CXX_FLAGS "-O2 -Werror -Wall -Wextra -fpic -pipe -march=native") #-Weffc++
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O3 -g -flto")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -flto -DNDEBUG")

# Install inside the build directory.
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install)

# Do not strip RPATH during installation
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
#set(CMAKE_INSTALL_RPATH "${CMAKE_BINARY_DIR}/grpc/xxx")

include_directories(.)

enable_testing()

add_subdirectory(test)
#add_subdirectory(doc)

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

#file(DOWNLOAD
#    https://github.com/CLIUtils/CLI11/releases/download/v1.9.1/CLI11.hpp
#    ${PROJECT_SOURCE_DIR}/lib/CLI11.hpp
#)