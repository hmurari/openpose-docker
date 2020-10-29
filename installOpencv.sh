#!/bin/sh

echo "OpenCV installation by learnOpenCV.com"

#Specify OpenCV version
cvVersion="master"

# Clean build directories
rm -rf opencv/build
rm -rf opencv_contrib/build
# Create directory for installation
mkdir installation
mkdir installation/OpenCV-"$cvVersion"


# Save current working directory
cwd=$(pwd)
apt -y update
apt -y upgrade

apt -y remove x264 libx264-dev

## Install dependencies
apt -y install build-essential checkinstall cmake pkg-config yasm
apt -y install git gfortran
apt -y install libjpeg8-dev libpng-dev

apt -y install software-properties-common
add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
apt -y update

apt -y install libjasper1
apt -y install libtiff-dev

apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
apt -y install libxine2-dev libv4l-dev
cd /usr/include/linux
ln -s -f ../libv4l1-videodev.h videodev.h
cd "$cwd"

apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
apt -y install libgtk2.0-dev libtbb-dev qt5-default
apt -y install libatlas-base-dev
apt -y install libfaac-dev libmp3lame-dev libtheora-dev
apt -y install libvorbis-dev libxvidcore-dev
apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
apt -y install libavresample-dev
apt -y install x264 v4l-utils

# Optional dependencies
apt -y install libprotobuf-dev protobuf-compiler
apt -y install libgoogle-glog-dev libgflags-dev
apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

apt -y install python3-dev python3-pip
-H pip3 install -U pip numpy
apt -y install python3-testresources

# now install python libraries within this virtual environment
pip3 install wheel numpy scipy matplotlib scikit-image scikit-learn ipython dlib

######################################

git clone https://github.com/opencv/opencv.git
cd opencv
#git checkout 3.4
cd ..

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
#git checkout 3.4
cd ..


cd opencv
mkdir build
cd build

######################################

cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
            -D WITH_CUDA=ON \
            -D WITH_CUDNN=ON \
            -D OPENCV_DNN_CUDA=ON \
            -D CUDA_ARCH_BIN=7.5 \
            -D ENABLE_FAST_MATH=1 \
            -D CUDA_FAST_MATH=1 \
            -D WITH_CUBLAS=1 \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_V4L=ON \
            -D WITH_GTK=ON \
            -D OPENCV_PYTHON3_INSTALL_PATH=/usr/local/lib/python3.6/dist-packages \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D OPENCV_PC_FILE_NAME=opencv.pc \
            -D OPENCV_ENABLE_NONFREE=ON \
            -D WITH_GSTREAMER=ON \
        -D WITH_QT=OFF \
        -D WITH_OPENGL=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D PYTHON_EXECUTABLE=/usr/bin/python3 \
        -D BUILD_EXAMPLES=ON ..

make -j$(nproc)
make install

cd $cwd
