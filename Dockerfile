# https://hub.docker.com/r/cwaffles/openpose
FROM nvidia/cuda:10.0-cudnn7-devel

#get deps
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
python3-dev python3-pip git g++ wget make libprotobuf-dev protobuf-compiler libopencv-dev \
libgoogle-glog-dev libboost-all-dev libcaffe-cuda-dev libhdf5-dev libatlas-base-dev \
python3-setuptools vim libgtk2.0-dev 


#for python api
RUN pip3 install cmake
RUN pip3 install scikit-build
RUN pip3 install numpy

# Install OpenCV
RUN mkdir -p /opencv
WORKDIR /opencv
RUN git clone https://github.com/hmurari/openpose-docker
WORKDIR /opencv/openpose-docker
RUN chmod +x installOpencv.sh
RUN ./installOpencv.sh

#replace cmake as old version has CUDA variable bugs
RUN wget https://github.com/Kitware/CMake/releases/download/v3.16.0/cmake-3.16.0-Linux-x86_64.tar.gz && \
tar xzf cmake-3.16.0-Linux-x86_64.tar.gz -C /opt && \
rm cmake-3.16.0-Linux-x86_64.tar.gz
ENV PATH="/opt/cmake-3.16.0-Linux-x86_64/bin:${PATH}"

#get openpose
WORKDIR /openpose
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git .

#build it
WORKDIR /openpose/build
RUN cmake -DBUILD_PYTHON=ON -DWITH_GTK=ON .. && make -j `nproc`
WORKDIR /openpose

# Build and install Openpose python
WORKDIR /openpose/build/python/openpose
RUN make install
RUN cp ./pyopenpose.cpython-36m-x86_64-linux-gnu.so /usr/local/lib/python3.6/dist-packages
WORKDIR /usr/local/lib/python3.6/dist-packages
RUN ln -s pyopenpose.cpython-36m-x86_64-linux-gnu.so pyopenpose
ENV LD_LIBRARY_PATH="/usr/local/lib/python3.6/dist-packages:${LD_LIBRARY_PATH}"

# Pull test code
WORKDIR /openpose
RUN git clone https://github.com/hmurari/pose2
