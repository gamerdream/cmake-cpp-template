@echo off
setlocal enabledelayedexpansion

:detect_cmake
cmd /c cmake --version 2>&1 | find "cmake version">nul || goto cmake_notfound

:detect_msvc
:detect_msvc_install
if not defined VCINSTALLDIR goto vs_notfound
:detect_msvc_version
cmd /c cl 2>&1 | find "16.00.">nul && set vc_version=10
cmd /c cl 2>&1 | find "17.00.">nul && set vc_version=11
cmd /c cl 2>&1 | find "18.00.">nul && set vc_version=12
cmd /c cl 2>&1 | find "19.00.">nul && set vc_version=14
cmd /c cl 2>&1 | find "19.10.">nul && set vc_version=15
cmd /c cl 2>&1 | find "19.11.">nul && set vc_version=15
cmd /c cl 2>&1 | find "19.12.">nul && set vc_version=15
cmd /c cl 2>&1 | find "19.13.">nul && set vc_version=15
cmd /c cl 2>&1 | find "19.14.">nul && set vc_version=15
cmd /c cl 2>&1 | find "19.15.">nul && set vc_version=15
cmd /c cl 2>&1 | find "19.16.">nul && set vc_version=15
cmd /c cl 2>&1 | find "19.20.">nul && set vc_version=16
cmd /c cl 2>&1 | find "19.21.">nul && set vc_version=16
cmd /c cl 2>&1 | find "19.22.">nul && set vc_version=16
cmd /c cl 2>&1 | find "19.23.">nul && set vc_version=16
if not defined vc_version goto vs_badversion
:detect_cpu
cmd /c cl 2>&1 | find "x86">nul && set cpu_arch=x86
cmd /c cl 2>&1 | find "x64">nul && set cpu_arch=x64
cmd /c cl 2>&1 | find "ARM">nul && set cpu_arch=arm
if not defined cpu_arch goto arch_unknown

:generate_solution
:create_target_if_not_exist
set target_directory=%~dp0..\targets\
if not exist !target_directory! mkdir %target_directory%
pushd %target_directory%
:init_cmake
set cmake_generator="Visual Studio %vc_version%"
if "!cpu_arch!" == "x86" set cmake_cpu_arch=Win32
if "!cpu_arch!" == "x64" set cmake_cpu_arch=x64
if "!cpu_arch!" == "arm" set cmake_cpu_arch=ARM
:invoke_cmake
cmd /c cmake -G %cmake_generator% -A %cmake_cpu_arch% %target_directory%.. 2>&1 || goto fail
popd
echo -- Configuration SUCCESS
goto exit

:cmake_notfound
echo ERROR: CMake not found
goto fail

:vs_notfound
echo ERROR: Visual Studio not found
goto fail

:vs_badversion
echo ERROR: Visual Studio version too old
goto fail

:arch_unknown
echo ERROR: Unknown build architecture
goto fail

:fail
echo -- Configuration FAILURE
pause && goto exit

:exit
echo.
endlocal
@echo on