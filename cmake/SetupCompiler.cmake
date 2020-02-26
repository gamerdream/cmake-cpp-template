# Detect Intel C/C++
if (CMAKE_C_COMPILER MATCHES ".*(icc|icpc).*" OR CMAKE_C_COMPILER_ID MATCHES ".*(Intel).*")
  set(COMPILER_IS_ICC TRUE)
else()
  set(COMPILER_IS_ICC FALSE)
endif()

# Detect Microsoft Visual Studio
if (MSVC OR CMAKE_C_COMPILER MATCHES ".*(cl).*" OR CMAKE_C_COMPILER_ID MATCHES ".*(MSVC).*")
  set(COMPILER_IS_MSVC TRUE)
else()
  set(COMPILER_IS_MSVC FALSE)
endif()

# Detect LLVM Clang
if (CMAKE_C_COMPILER MATCHES ".*(clang|emcc).*" OR CMAKE_C_COMPILER_ID MATCHES ".*(Clang|emcc).*")
	set(COMPILER_IS_CLANG TRUE)
else()
  set(COMPILER_IS_CLANG FALSE)
endif()

# Detect GNU-like environment
if (CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX OR CMAKE_C_COMPILER MATCHES ".*(gcc|clang|emcc).*" OR CMAKE_C_COMPILER_ID MATCHES ".*(GCC|Clang|emcc).*")
	set(IS_GCC_LIKE TRUE)
else()
	set(IS_GCC_LIKE FALSE)
endif()

# Detect GNU C/C++
if (IS_GCC_LIKE AND NOT COMPILER_IS_CLANG)
	set(COMPILER_IS_GCC TRUE)
else()
  set(COMPILER_IS_GCC FALSE)
endif()

# Set compiler-independent options
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
if(BUILD_SHARED)
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
  if(WIN32)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
  endif(WIN32)
endif(BUILD_SHARED)

# Load compiler specific flags
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/Compiler")
if (COMPILER_IS_ICC)
  include(flags-icc)
elseif(COMPILER_IS_MSVC)
  include(flags-msvc)
elseif(COMPILER_IS_CLANG)
  include(flags-clang)
elseif(COMPILER_IS_GCC)
  include(flags-gcc)
else()
  message(FATAL_ERROR "CMake compiler toolset not supported!")
endif()
