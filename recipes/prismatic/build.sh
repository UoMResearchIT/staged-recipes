

mkdir build && cd build 

enable_cli=0
enable_gui=0
enable_py=0


if [[ $interface == "cli" ]]; then
	enable_cli=1
elif [[ $interface == "gui" ]]; then
	enable_gui=1
fi

cmake -D PRISMATIC_ENABLE_GUI=$enable_gui \
	-D PRISMATIC_ENABLE_CLI=$enable_cli \
	-D CMAKE_INSTALL_PREFIX=$PREFIX \
	-D CMAKE_PREFIX_PATH=${PREFIX} \
	../ 

make  -j${CPU_COUNT}

make install
