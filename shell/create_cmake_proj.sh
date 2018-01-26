#!/bin/bash

project_name=$1

mkdir $project_name
cd $project_name

project_type="cpp"
if [[ $2 ]]
then
    project_type=$2
fi

if [[ $project_type == "cpp" ]]
then
    cat > CMakeLists.txt << CPP_CMAKELISTS_EOF
cmake_minimum_required(VERSION 2.6)
project($project_name)
SET(CMAKE_CXX_FLAGS_DEBUG "\$ENV{CXXFLAGS} -O0 -Wall -g -ggdb ")
SET(CMAKE_CXX_FLAGS_RELEASE "\$ENV{CXXFLAGS} -O3 -Wall")

set(CMAKE_CXX_STANDARD 11)
add_executable($project_name main.cpp)
CPP_CMAKELISTS_EOF
    cat > main.cpp << CPP_SRC_EOF
#include<iostream>
using namespace std;

int main(int argc, char *argv[]){
    
    return 0;
}
CPP_SRC_EOF

fi

if [[ $project_type == "c" ]]
then 
    cat > CMakeLists.txt << C_CMAKELISTS_EOF
cmake_minimum_required(VERSION 2.6)
project($project_name)
SET(CMAKE_C_FLAGS_DEBUG "\$ENV{CFLAGS} -O0 -Wall -g")
SET(CMAKE_C_FLAGS_RELEASE "\$ENV{CFLAGS} -O3 -Wall")

set(CMAKE_C_STANDARD 99)
add_executable($project_name main.c)
C_CMAKELISTS_EOF
    cat > main.c << C_SRC_EOF
#include<stdio.h>
#include<stdlib.h>

int main(int argc, char *argv[]){

    return 0;
}
C_SRC_EOF
fi

mkdir cmake_build_debug
cd cmake_build_debug

cat > debug_run << DEBUG_SHELL_EOF
#!/bin/bash
cmake -D CMAKE_BUILD_TYPE=DEBUG ..
make
./$project_name
DEBUG_SHELL_EOF


cat > release_run << RUN_SHELL_EOF
#!/bin/bash
cmake -D CMAKE_BUILD_TYPE=RELEASE ..
make
./$project_name
RUN_SHELL_EOF

chmod +x debug_run release_run
