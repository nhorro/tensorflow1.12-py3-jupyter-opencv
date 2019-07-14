FROM tensorflow/tensorflow:1.12.0-gpu-py3

# Build and install OpenCV
RUN apt-get update -y
RUN apt-get install git cmake -y
RUN pip install --upgrade pip
RUN git clone https://github.com/opencv/opencv.git /usr/local/src/opencv
RUN cd /usr/local/src/opencv/ && mkdir build
RUN cd /usr/local/src/opencv/build && cmake -D CMAKE_INSTALL_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local/ .. && make -j4 && make install

RUN pip install requests
RUN apt-get install graphviz -y
RUN pip install pydot

# Tensorflow serving client
RUN pip install tensorflow-serving-api

# Default command with notebook
CMD ["jupyter", "notebook", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''", "--notebook-dir=/tf/notebooks"]
