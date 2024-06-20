#/bin/bash

EVAL_DIR=`pwd`
AFL_DIR=${AFL_DIR:-/Racing-eval/afl-fuzz}
AURORA_GIT_DIR=${AURORA_GIT_DIR:-/Racing-eval/aurora}

cd ../binutils-2.32
make distclean
find . -type f -name "config.cache" -delete

export AFL_CC=clang-6.0
# build instrument version for fuzzing
CC=$AFL_DIR/afl-clang-fast  CFLAGS="-g -O0 -fsanitize=address" ./configure --disable-shared
ASAN_OPTIONS=detect_leaks=0 make

mv $PWD/binutils/objdump $EVAL_DIR/objdump_fuzz.aurora
