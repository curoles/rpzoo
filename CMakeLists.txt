cmake_minimum_required(VERSION 3.17)

project(RPZOO CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)


include_directories(.)

set(CMAKE_CXX_FLAGS "-O2 -Werror -Wall -Wextra -Weffc++ -fpic -pipe -march=native")
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
#set(QPP_INCLUDE_DIR ${INSTALL_DIR}/include)
message(STATUS "gRPC installation: ${INSTALL_DIR}")

# Do not strip RPATH during installation
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

enable_testing()

#add_subdirectory(sim)
#add_subdirectory(test)
#add_subdirectory(doc)

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")