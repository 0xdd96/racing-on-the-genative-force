FROM ubuntu:20.04


RUN apt-get update \
    && apt-get install -y wget make gcc clang-6.0 autoconf git python3 parallel

RUN mkdir /Racing-eval && cd /Racing-eval \
    && wget -c http://software.intel.com/sites/landingpage/pintool/downloads/pin-3.15-98253-gb56e429b1-gcc-linux.tar.gz \
    && tar -xzf pin*.tar.gz

WORKDIR /Racing-eval
# RUN git clone https://github.com/0xdd96/Racing-final
ADD InstTracer InstTracer
ADD Racing-code Racing-code
ADD scripts scripts

ENV PIN_ROOT="/Racing-eval/pin-3.15-98253-gb56e429b1-gcc-linux"
ENV RACING_DIR="/Racing-eval"

ENV LLVM_CONFIG=llvm-config-6.0
ENV CC=clang-6.0
ENV CXX=clang++-6.0
ENV AFL_CC=clang-6.0
ENV AFL_CXX=clang++-6.0

RUN cd ${RACING_DIR}/InstTracer && make
RUN cd ${RACING_DIR}/Racing-code && make
RUN cd ${RACING_DIR}/Racing-code/llvm_mode && make