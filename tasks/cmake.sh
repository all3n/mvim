BUILD=$ROOT/build
mkdir -p $BUILD
cd $BUILD
cmake ..
make -j$(nproc)
