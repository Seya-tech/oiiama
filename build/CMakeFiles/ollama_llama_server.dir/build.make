# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /workspaces/ollama/llm/ext_server

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /workspaces/ollama/build

# Include any dependencies generated for this target.
include CMakeFiles/ollama_llama_server.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/ollama_llama_server.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ollama_llama_server.dir/flags.make

CMakeFiles/ollama_llama_server.dir/server.o: CMakeFiles/ollama_llama_server.dir/flags.make
CMakeFiles/ollama_llama_server.dir/server.o: /workspaces/ollama/llm/ext_server/server.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/workspaces/ollama/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/ollama_llama_server.dir/server.o"
	/usr/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/ollama_llama_server.dir/server.o -c /workspaces/ollama/llm/ext_server/server.cpp

CMakeFiles/ollama_llama_server.dir/server.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ollama_llama_server.dir/server.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /workspaces/ollama/llm/ext_server/server.cpp > CMakeFiles/ollama_llama_server.dir/server.i

CMakeFiles/ollama_llama_server.dir/server.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ollama_llama_server.dir/server.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /workspaces/ollama/llm/ext_server/server.cpp -o CMakeFiles/ollama_llama_server.dir/server.s

# Object files for target ollama_llama_server
ollama_llama_server_OBJECTS = \
"CMakeFiles/ollama_llama_server.dir/server.o"

# External object files for target ollama_llama_server
ollama_llama_server_EXTERNAL_OBJECTS =

ollama_llama_server: CMakeFiles/ollama_llama_server.dir/server.o
ollama_llama_server: CMakeFiles/ollama_llama_server.dir/build.make
ollama_llama_server: CMakeFiles/ollama_llama_server.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/workspaces/ollama/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ollama_llama_server"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ollama_llama_server.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/ollama_llama_server.dir/build: ollama_llama_server

.PHONY : CMakeFiles/ollama_llama_server.dir/build

CMakeFiles/ollama_llama_server.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ollama_llama_server.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ollama_llama_server.dir/clean

CMakeFiles/ollama_llama_server.dir/depend:
	cd /workspaces/ollama/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /workspaces/ollama/llm/ext_server /workspaces/ollama/llm/ext_server /workspaces/ollama/build /workspaces/ollama/build /workspaces/ollama/build/CMakeFiles/ollama_llama_server.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ollama_llama_server.dir/depend

