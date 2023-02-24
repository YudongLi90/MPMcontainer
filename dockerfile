FROM ubuntu:20.04
CMD ["bash"]
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl netbase wget
RUN apt-get upgrade -y --no-install-recommends
RUN apt-get install -y --no-install-recommends gcc git libboost-all-dev libeigen3-dev libhdf5-serial-dev libopenmpi-dev libomp-dev
#RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
RUN apt update
RUN apt upgrade
RUN apt-get install -y --no-install-recommends freeglut3-dev libxt-dev
RUN apt-get install -y --no-install-recommends cmake g++ gcc automake make build-essential mesa-common-dev mesa-utils freeglut3-dev ninja-build
WORKDIR /workspace/
RUN git config --global http.sslverify false
RUN git clone --recursive https://gitlab.kitware.com/vtk/vtk.git VTK
WORKDIR /workspace/VTK
RUN mkdir build
WORKDIR /workspace/VTK/build
RUN cmake -DCMAKE_BUILD_TYPE:STRING=Release ..
RUN make
RUN make install
WORKDIR /workspace/
RUN git clone --recursive https://github.com/wdas/partio.git partio
WORKDIR /workspace/partio
RUN cmake .
RUN make
WORKDIR /workspace/
RUN git clone --recursive https://github.com/schulzchristian/KaHIP KaHIP
WORKDIR /workspace/KaHIP/
RUN /workspace/KaHIP/compile_withcmake.sh
WORKDIR /workspace/
#RUN git clone --recursive https://github.com/cb-geo/mpm.git mpm
#WORKDIR /workspace/mpm/
#RUN mkdir mpm
#WORKDIR /workspace/mpm/build/
#RUN cmake -DCMAKE_CXX_COMPILER=g++ -DPARTIO_ROOT=/workspace/partio/ -DKAHIP_ROOT=/workspace/KaHIP/ ..
#RUN make clean
#RUN make
RUN useradd mpm
USER mpm
ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
