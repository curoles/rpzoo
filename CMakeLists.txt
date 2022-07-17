cmake_minimum_required(VERSION 3.17)

project(RPZOO CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)


set(CMAKE_CXX_FLAGS "-O2 -Werror -Wall -Wextra -fpic -pipe -march=native") #-Weffc++
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O3 -g -flto")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -flto -DNDEBUG -DEIGEN_NO_DEBUG")

# Install inside the build directory.
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

include(external_grpc.cmake)
ExternalProject_Get_property(grpc INSTALL_DIR)
set(gRPC_BIN_DIR ${INSTALL_DIR}/bin)
set(gRPC_LIB_DIR ${INSTALL_DIR}/lib)
set(gRPC_INCLUDE_DIR ${INSTALL_DIR}/include)
message(STATUS "gRPC installation: ${INSTALL_DIR}")

# Do not strip RPATH during installation
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
#set(CMAKE_INSTALL_RPATH "${CMAKE_BINARY_DIR}/grpc/xxx")

include_directories(.)
include_directories(${gRPC_INCLUDE_DIR})
link_directories(${gRPC_LIB_DIR})

enable_testing()

add_subdirectory(test)
#add_subdirectory(doc)

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

#file(DOWNLOAD
#    https://github.com/CLIUtils/CLI11/releases/download/v1.9.1/CLI11.hpp
#    ${PROJECT_SOURCE_DIR}/lib/CLI11.hpp
#)