if(NOT TARGET googletest)
	include(ExternalProject)

	# gtest should be build with the same compiler as the project using it
	ExternalProject_Add(
		googletest
		URL http://insieme-compiler.org/ext_libs/gtest-1.8.0.tar.gz
		URL_HASH SHA256=58a6f4277ca2bc8565222b3bbd58a177609e9c488e8a72649359ba51450db7d8
		INSTALL_COMMAND ""
		CMAKE_ARGS
			-DCMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM}
			-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
			-DCMAKE_C_COMPILER_ARG1=${CMAKE_C_COMPILER_ARG1}
			-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
			-DCMAKE_CXX_COMPILER_ARG1=${CMAKE_CXX_COMPILER_ARG1}
		DOWNLOAD_NO_PROGRESS 1
	)
	ExternalProject_Get_Property(googletest source_dir binary_dir)

	# import libgtest
	add_library(gtest STATIC IMPORTED)
	set(gtest ${CMAKE_STATIC_LIBRARY_PREFIX}gtest${CMAKE_STATIC_LIBRARY_SUFFIX})
	if(NOT MSVC)
		set_target_properties(gtest PROPERTIES IMPORTED_LOCATION ${binary_dir}/googlemock/gtest/${gtest})
	else()
		set_target_properties(gtest PROPERTIES IMPORTED_LOCATION ${binary_dir}/googlemock/gtest/Debug/${gtest})
	endif()
	add_dependencies(gtest googletest)

	# import libgtest_main
	add_library(gtest_main STATIC IMPORTED)
	set(gtest_main ${CMAKE_STATIC_LIBRARY_PREFIX}gtest_main${CMAKE_STATIC_LIBRARY_SUFFIX})
	if(NOT MSVC)
		set_target_properties(gtest_main PROPERTIES IMPORTED_LOCATION ${binary_dir}/googlemock/gtest/${gtest_main})
	else()
		set_target_properties(gtest_main PROPERTIES IMPORTED_LOCATION ${binary_dir}/googlemock/gtest/Debug/${gtest_main})
	endif()
	add_dependencies(gtest_main googletest)

	# cannot attach include path to gtest target, must be added manually
	set(GTEST_INCLUDE_PATH ${source_dir}/googletest/include)
endif()
