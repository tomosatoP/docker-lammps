ARG CUDA_TAG
FROM nvidia/cuda:$CUDA_TAG
WORKDIR /

# system update, and install Related Packages
RUN apt-get update -yq && apt-get upgrade -yq \
    && DEBIAN_FRONTEND=noninteractive apt install -yq --no-install-recommends \
       git \
       cmake build-essential ccache gfortran \
       libfftw3-dev \
       openmpi-bin libopenmpi-dev libomp-dev \
       libjpeg-dev libpng-dev ffmpeg \
       libblas-dev liblapack-dev \
       libhdf5-serial-dev hdf5-tools \
       python3-dev python3-pip python3-venv \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# build lammps
ENV LD_LIBRARY_PATH="/usr/local/lib:/usr/local/cuda/lib64:/usr/local/cuda/compat:${LD_LIBRARY_PATH}"
COPY ./lammps /lammps
RUN mkdir -p /build && cd /build \
    && cmake /lammps/cmake/presets/all_on.cmake \
       -D CMAKE_INSTALL_PREFIX=/usr/local \
       -D BUILD_SHARED_LIBS=yes \
       -D WITH_JPEG=yes -D WITH_PNG=yes -D WITH_FFMPEG=yes \
       -D PKG_OPT=yes \
       -D BUILD_MPI=yes \
       -D PKG_OPENMP=yes -D BUILD_OMP=yes \
       -D PKG_GPU=yes -D GPU_API=cuda -D GPU_ARCH=sm_86 \
       /lammps/cmake/ \
    && cmake --build . \
    && make install

# run
WORKDIR /data
#ENTRYPOINT ["/bin/bash"]
CMD ["lmp", "-help" ]
