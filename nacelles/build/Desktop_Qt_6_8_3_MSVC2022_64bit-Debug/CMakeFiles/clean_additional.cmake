# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appnacelles_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appnacelles_autogen.dir\\ParseCache.txt"
  "appnacelles_autogen"
  )
endif()
