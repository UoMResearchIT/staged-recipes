enable_cli=1
enable_gui=0
enable_py=1
enable_double=0
enable_gpu=0

if [[ $interface == "gui" ]]; then
	enable_gui=1
fi

if [[ $processor == "gpu" ]]; then
	enable_gpu=1
	enable_py=0
fi


mkdir build && cd build 

cmake -D PRISMATIC_ENABLE_GUI=$enable_gui \
	-D PRISMATIC_ENABLE_CLI=$enable_cli \
	-D PRISMATIC_ENABLE_DOUBLE_PRECISION=$enable_double \
	-D PRISMATIC_ENABLE_GPU=$enable_gpu \
	-D PRISMATIC_ENABLE_PYPRISMATIC=$enable_py \
	-D CMAKE_INSTALL_PREFIX=$PREFIX \
	-D CMAKE_PREFIX_PATH=${PREFIX} \
	../ 

make  -j${CPU_COUNT} # make all interfaces

make install  # install the GUI and CLI interfaces

# install the python interface (this isn't setup in the CMake file)
if [[ $enable_py == 1 ]]; then
	install_dir=${PREFIX}/lib/python3.7/site-packages/pyprismatic
	mkdir $install_dir
	cp core.* $install_dir
	cp ../pyprismatic/* $install_dir
fi


