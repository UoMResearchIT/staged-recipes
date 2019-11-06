


enable_cli=0
enable_gui=0
enable_py=0
enable_double=0
enable_gpu=0

if [[ $interface == "cli" ]]; then
	enable_cli=1
	extra_opts=""
elif [[ $interface == "gui" ]]; then
	enable_gui=1
	extra_opts=""
elif [[ $interface == "py" ]]; then
	enable_py=1
	extra_opts="-D "
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

make  -j${CPU_COUNT}


if [[ $interface == "py" ]]; then
	install_dir=${PREFIX}/lib/python3.7/site-packages/pyprismatic
	mkdir $install_dir
	cp core.* $install_dir
	cp ../pyprismatic/* $install_dir
else
	make install
fi


