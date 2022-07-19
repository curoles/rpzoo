#include(ExternalProject)

# FetchContent? see https://github.com/grpc/grpc/tree/master/src/cpp#to-start-using-grpc-c
# https://grpc.io/docs/languages/cpp/quickstart/
#ExternalProject_Add(gRPC
#    PREFIX grpc
#    GIT_REPOSITORY https://github.com/grpc/grpc
#    GIT_TAG v1.47.1
#    GIT_SHALLOW TRUE
#    GIT_SUBMODULES_RECURSE TRUE
#    GIT_PROGRESS TRUE
#    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/grpc -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD} -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF
#    BUILD_COMMAND make -j
#    INSTALL_COMMAND make install
#    UPDATE_COMMAND ""
#)
#include(external_grpc.cmake)
#ExternalProject_Get_property(grpc INSTALL_DIR)
#set(gRPC_BIN_DIR ${INSTALL_DIR}/bin)
#set(gRPC_LIB_DIR ${INSTALL_DIR}/lib)
#set(gRPC_INCLUDE_DIR ${INSTALL_DIR}/include)
#message(STATUS "gRPC installation: ${INSTALL_DIR}")
#include_directories(${gRPC_INCLUDE_DIR})
#link_directories(${gRPC_LIB_DIR})

include(FetchContent)
FetchContent_Declare(
    gRPC
    GIT_REPOSITORY https://github.com/grpc/grpc
    GIT_TAG        v1.47.1
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)
set(FETCHCONTENT_QUIET OFF)
FetchContent_MakeAvailable(gRPC)