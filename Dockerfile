FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
LABEL maintainer pkdogcom@gmail.com

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        build-essential cmake git wget && \
    apt-get install -y --no-install-recommends \
	pkg-config unzip ffmpeg qtbase5-dev python-dev python-numpy python-py \
	libgtk2.0-dev libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev zlib1g-dev libglew-dev \ 
	libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \	
        libv4l-dev libtbb-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev \
        libvorbis-dev libxvidcore-dev v4l-utils libhdf5-serial-dev libeigen3-dev libtbb-dev libpostproc-dev && \
    rm -rf /var/lib/apt/lists/*

# Build OpenCV with CUDA
RUN \
    cd ~ && \ 
    git clone https://github.com/Itseez/opencv.git && \
    cd opencv && \
    pwd && \
    git checkout -b v3.2.0 3.2.0 &&\

    cd ~ && \
    git clone https://github.com/Itseez/opencv_contrib.git && \ 

    cd ~/opencv && \ 
    mkdir build && \ 
    cd build && \
    cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr/local \
	-DBUILD_EXAMPLES=OFF \
	-DBUILD_opencv_java=OFF \
	-DBUILD_opencv_python2=ON \
	-DBUILD_opencv_python3=OFF \
	-DWITH_FFMPEG=ON \
	-DWITH_CUDA=ON \
	-DWITH_GTK=ON \
	-DWITH_TBB=ON \
	-DWITH_V4L=ON \
	-DWITH_QT=ON \
	-DWITH_OPENGL=ON \
	-DWITH_CUBLAS=ON \	
	-DWITH_1394=OFF \
	-DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0 \
	-DCUDA_ARCH_PTX="" \
	-DCUDA_NVCC_FLAGS="-D_FORCE_INLINES" \ 
	-DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
	-DINSTALL_C_EXAMPLES=OFF \
	-DINSTALL_TESTS=OFF \
	-DOPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules .. && \

    make -j $(nproc) && \ 
    make install && \ 
    ldconfig && \

    cp ~/opencv/build/lib/cv2.so /usr/local/lib/python2.7/dist-packages/ && \
    rm -rf ~/opencv/build 
    

    

    

