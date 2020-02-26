set(CLANG_DEFAULT_FLAGS
	-Werror
	-Wall

	-fvisibility-inlines-hidden
	-fvisibility=hidden
	-fPIC

	-D_HAS_C9X

	-fdata-sections
	-ffunction-sections
	-fno-omit-frame-pointer
	-fno-strict-aliasing
	-funwind-tables
	-gfull
	-ffast-math
	-fno-rtti

	# clang 3.8 -> 5.0 upgrade
	-Wno-unknown-warning-option      # Allows multiple versions of clang to be used
	-Wno-delete-non-virtual-dtor     # Needed to provide virtual dispatch to allow strings to be modified on CryCommon types
  
  $<GENERATE_ASM_LISTING:-S -fkeep-inline-functions -fverbose-asm -g -mllvm --x86-asm-syntax=intel>
)
string(REPLACE ";" " " CLANG_DEFAULT_FLAGS "${CLANG_DEFAULT_FLAGS}")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CLANG_DEFAULT_FLAGS}" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0 -D_DEBUG -DDEBUG" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_FLAGS_PROFILE "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} -O3 -D_PROFILE -DNDEBUG" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -D_RELEASE -DNDEBUG" CACHE INTERNAL "" FORCE)

set(CMAKE_LINK_FLAGS "{$CMAKE_LINK_FLAGS} -Wl, --gc-sections")
set(CMAKE_SHARED_LINKER_FLAGS_PROFILE ${CMAKE_SHARED_LINKER_FLAGS_DEBUG} CACHE STRING "Linker Library Profile Flags" FORCE)
set(CMAKE_EXE_LINKER_FLAGS_PROFILE ${CMAKE_EXE_LINKER_FLAGS_DEBUG} CACHE STRING "Linker Executable Profile Flags" FORCE)
