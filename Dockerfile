FROM quay.io/pypa/manylinux2014_x86_64

RUN yum -y update && yum -y install \
    wget \
    zlib-devel \
    && yum clean all

RUN mkdir -p /opt/cmake \
    && wget https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-Linux-x86_64.sh \
    && sh cmake-3.16.2-Linux-x86_64.sh  --skip-license --prefix=/opt/cmake \
    && rm -f cmake-3.16.2-Linux-x86_64.sh \
    && git clone https://github.com/pybind/pybind11 \
    && /opt/python/cp38-cp38/bin/python3 -m pip install pytest \
    && mkdir build \
    && cd build \
    && /opt/cmake/bin/cmake -DPYBIND11_TEST=OFF ../pybind11/ \
    && make -j \
    && make install \
    && cd .. \
    && rm -rf build pybind11 \
    && /opt/python/cp35-cp35m/bin/pip install scikit-build ninja\
    && /opt/python/cp36-cp36m/bin/pip install scikit-build ninja\
    && /opt/python/cp37-cp37m/bin/pip install scikit-build ninja\
    && /opt/python/cp38-cp38/bin/pip install scikit-build ninja twine

ENV PYTHON35="/opt/python/cp35-cp35m/"
ENV PYTHON36="/opt/python/cp36-cp36m/"
ENV PYTHON37="/opt/python/cp37-cp37m/"
ENV PYTHON38="/opt/python/cp38-cp38/"

ENV PATH="/opt/cmake/bin:${PATH}"

