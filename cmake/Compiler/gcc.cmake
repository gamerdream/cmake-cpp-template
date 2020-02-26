set(GCC_DEFAULT_FLAGS
	-Wall
	-Werror

	-ffast-math
	-flax-vector-conversions
	-fvisibility=hidden
	-fPIC
	-fno-exceptions

	-Wno-unknown-warning
  
  -fno-rtti
	-Wno-invalid-offsetof
	-Wno-aligned-new
	-Wno-conversion-null
	-Wno-unused-result
	-Wno-reorder
	-Wno-delete-non-virtual-dtor # Needed to provide virtual dispatch to allow strings to be modified on CryCommon types
	-Wno-class-memaccess
  
  $<GENERATE_ASM_LISTING:-S -fkeep-inline-functions -fverbose-asm -g -masm=intel -Wa,-alnd>
)
string(REPLACE ";" " " GCC_DEFAULT_FLAGS "${GCC_DEFAULT_FLAGS}")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GCC_DEFAULT_FLAGS}" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0 -D_DEBUG -DDEBUG" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_FLAGS_PROFILE "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} -O2 -D_PROFILE -DNDEBUG" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -D_RELEASE -DNDEBUG" CACHE INTERNAL "" FORCE)

set(CMAKE_LINK_FLAGS "{$CMAKE_LINK_FLAGS} -Wl, --gc-sections")
set(CMAKE_SHARED_LINKER_FLAGS_PROFILE ${CMAKE_SHARED_LINKER_FLAGS_DEBUG} CACHE STRING "Linker Library Profile Flags" FORCE)
set(CMAKE_EXE_LINKER_FLAGS_PROFILE ${CMAKE_EXE_LINKER_FLAGS_DEBUG} CACHE STRING "Linker Executable Profile Flags" FORCE)
