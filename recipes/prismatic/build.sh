


enable_cli=0
enable_gui=0
enable_py=0
enable_double=0
enable_gpu=0


if [[ $interface == "cli" ]]; then
	enable_cli=1
elif [[ $interface == "gui" ]]; then
	enable_gui=1
fi

if [[ $interface != "py" ]]; then

	mkdir build && cd build 

	cmake -D PRISMATIC_ENABLE_GUI=$enable_gui \
		-D PRISMATIC_ENABLE_CLI=$enable_cli \
		-D PRISMATIC_ENABLE_DOUBLE_PRECISION=$enable_double \
		-D PRISMATIC_ENABLE_GPU=$enable_gpu \
		-D CMAKE_INSTALL_PREFIX=$PREFIX \
		-D CMAKE_PREFIX_PATH=${PREFIX} \
		../ 

	make  -j${CPU_COUNT}

	make install

else
	python3 setup.py install --debug
fi