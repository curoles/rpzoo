include(ExternalProject)

# FetchContent? see https://github.com/grpc/grpc/tree/master/src/cpp#to-start-using-grpc-c
# https://grpc.io/docs/languages/cpp/quickstart/
ExternalProject_Add(grpc
    PREFIX grpc
    GIT_REPOSITORY https://github.com/grpc/grpc
    GIT_TAG v1.47.1
    GIT_SHALLOW TRUE
    GIT_SUBMODULES_RECURSE TRUE
    GIT_PROGRESS TRUE
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/grpc -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD} -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF
    BUILD_COMMAND make -j
    INSTALL_COMMAND make install
    UPDATE_COMMAND ""
)

#include(FetchContent)
#FetchContent_Declare(
#  gRPC
#  GIT_REPOSITORY https://github.com/grpc/grpc
#  GIT_TAG        v1.47.1
#)
#set(FETCHCONTENT_QUIET OFF)
#FetchContent_MakeAvailable(gRPC)