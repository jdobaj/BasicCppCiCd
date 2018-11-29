# Basic C++ CI/CD Example

## Libraries used

- [spdlog](https://github.com/gabime/spdlog) for a moderm log system. (as submodule)
- [catch](https://github.com/philsquared/Catch) as the test framework.  (as submodule)

### Libraries planed to be used

- boost
- qt
- CppMicroservices
- OpenDDS

## Project structure

| folder       | Content              |
| ------------ | -------------------- |
| [/lib](/lib) | library |
| [/lib/src](/lib/src) | library sources  |
| [/lib/include](/lib/include) | library includes |
| [/lib/test](/lib/test) | library test |
| [/app](/app) | application |
| [/app/src](/app/src) | application sources  |
| [/app/test](/app/test) | application test |
| [/third-party](/third-party) | third party software        |

## Generate project

```shell
  cmake -H. -BBuild
```

Auto detect everything.

If you like to set a implicit compiler set the variable CXX=${COMPILER}, for example COMPILER could be gcc, clang and so on.

Auto detect in Windows usually generate a Visual Studio project since msbuild require it, but in OSX does not generate and XCode project, since is not required for compiling using XCode clang.

Specify build type debug/release

```shell
  # generate a debug project
  cmake -H. -BBuild -DCMAKE_BUILD_TYPE=Debug
  # generate a release project
  cmake -H. -BBuild -DCMAKE_BUILD_TYPE=Release
```

Specify architecture

```shell
  # 64 bits architecture
  cmake -H. -BBuild -Ax64
  # ARM architecture
  cmake -H. -BBuild -AARM
  # Windows 32 bits architecture
  cmake -H. -BBuild -AxWin32
```

Generate different project types

```shell
  # MinGW makefiles
  cmake -H. -BBuild -G "MinGW Makefiles"
  # XCode project
  cmake -H. -BBuild -G "XCode"
  # Visual Studio 15 2017 solution
  cmake -H. -BBuild -G "Visual Studio 15 2017"
```

## Build

From the Build folder

```shell
  # build the default build type (in multi build types usually debug)
  cmake --build .
  # build a specific build type
  cmake --build . --config Release
```

## Run tests

From the Build folder

```shell
  # run all test using the default build type
  ctest -V
  # run all test in Release build type
  ctest -V -C Release
```

## todo

- Setup docker build and docker-compose
- Build inside docker
- Implement a generic build-, configure-, test-, run-, install-script (see for example x11vnc-desktop)
  - also automatically generate the file with the environment variables
- Make docker-compose production ready (multi stage build, volumes, ) (see https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds)
  - create at least a develop, debug, test, deploy stage
- Setup VSC to invoke docker build scripts
- Create CMake install and invoke that inside docker
- Create different/multi-stages images for deployment, development, testing,...
- Use small base images e.g. the Alpine image by using the from instruction (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#dockerfile-instructions)
- Use labels
- Create .dockerignore file
- Create CMake test etc.: everything that is required for a development and production ready environment
- Cleanup docker build and apply best practice
- Create a configuration file
- Setup generic build script using python
- Setup CI for Linux
- Setup CI for Windows
- Setup CI with docker on Linux and Windows
- Setup CD using docker
- Setup Kubernetes
- Adjust documentation
- Implement tests including integration tests (python?)
- Implement examples

## references

- https://cmake.org/
- https://docs.travis-ci.com/user/languages/cpp/
- https://www.appveyor.com/docs/lang/cpp/
- https://github.com/isocpp/CppCoreGuidelines
- https://github.com/philsquared/Catch
- https://github.com/gabime/spdlog
- https://github.com/cognitivewaves/CMake-VisualStudio-Example
- http://derekmolloy.ie/hello-world-introductions-to-cmake/
- https://cmake.org/Wiki/CMake/Testing_With_CTest
- https://www.appveyor.com/docs/lang/cpp/
- https://docs.travis-ci.com/user/languages/cpp/
- https://github.com/philsquared/Catch/blob/master/docs/build-systems.md
- https://stackoverflow.com/questions/14446495/cmake-project-structure-with-unit-tests