#in source directory
#for project with BUILD_TEST_COVERAGE option
#
cmake -S . -B build -GNinja -DBUILD_TEST_COVERAGE=ON -DBUILD_SHARED_LIBS=OFF -DGIT_HELPER=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_COMPILER=/usr/bin/g++  -DCMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_MAKE_PROGRAM=/home/daria/Qt/Tools/Ninja/ninja -DQT_DIR=/home/daria/Qt/5.15.2/gcc_64/lib/cmake/Qt5 -DCMAKE_PREFIX_PATH=/home/daria/Qt/5.15.2/gcc_64
cmake --build build
lcov --no-external --capture --initial --directory . --output-file coverage_baseline.info
cd build
ctest -L unittest -j4 --output-on-failure --output-log ctest.log
cd ..
lcov --no-external --capture --directory . --output-file coverage_tests.info
lcov --add-tracefile coverage_baseline.info --add-tracefile coverage_tests.info --output-file coverage_all.info
lcov --remove coverage_all.info "`pwd`/build/*" "`pwd`/thirdparty/*" "`pwd`/*tst_*" -o coverage.info
rm -rf coverage
genhtml --ignore-errors source coverage.info --output-directory=coverage

