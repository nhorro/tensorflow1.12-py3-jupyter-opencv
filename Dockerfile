FROM tensorflow/tensorflow:1.12.0-gpu-py3

# Build and install OpenCV4 with ffmpeg and gstreamer
RUN apt-get update -y
RUN apt-get install -y \
	git \
	cmake \
	graphviz \
	libtbb2 \
	ffmpeg \
	libgtk2.0-dev \
	libavformat-dev \
	libswscale-dev \
	libtbb-dev \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libdc1394-22-dev \
	libgstreamer1.0-dev \
	libgstreamer-plugins-base1.0-dev 

RUN pip install --upgrade pip
RUN git clone https://github.com/opencv/opencv.git /usr/local/src/opencv
RUN git clone https://github.com/opencv/opencv_contrib.git /usr/local/src/opencv_contrib
RUN git clone https://github.com/opencv/opencv_extra.git /usr/local/src/opencv_extra
RUN cd /usr/local/src/opencv/ && git checkout 4.1.0 && mkdir build
RUN cd /usr/local/src/opencv/build && \
	cmake -D CMAKE_INSTALL_TYPE=Release \
	      -D WITH_GSTREAMER=ON \
	      -D CMAKE_INSTALL_PREFIX=/usr/local/ \
	      –D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
	      -D INSTALL_C_EXAMPLES=OFF .. && \
	      make -j4 && \
	      make install && \
	      ldconfig && \
	      make clean

# Other libraries (FIXME do not install opencv-contrib-python, instead: build from source)
RUN pip install requests \
                pydot \
                opencv-contrib-python \
                tensorflow-serving-api==1.12.0 \
				grpcio-tools \
				influxdb

# Default command with notebook
CMD ["jupyter", "notebook", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''", "--notebook-dir=/tf/notebooks"]