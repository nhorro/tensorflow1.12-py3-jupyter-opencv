# tensorflow1.12-py3-jupyter-opencv

Dockerfile from official Tensorflow r1.12 GPU/Python3/Jupyter image with some additions.

The purpose of this image is to develop Tensorflow and OpenCV applications with GPU support development in older machines not supporting CUDA 10.0, such as Geforce GTX 950M.

This image uses Tensorflow 1.12, which is the latest supporting supporting CUDA 9.0 and adds:

- OpenCV 4.1 with ffmpeg and gstreamer to enable video I/O (built from source)
- requests
- Graphviz and PyDot (for Keras model diagrams).

Jupyter Notebooks are served from the same directory as in the official image: /tf/notebooks with token and password disabled.

## Usage example

Run a Jupyter notebook server mounting directory ./my-notebooks:

```bash
docker run -it --rm --runtime=nvidia -v $(realpath $PWD/my-notebooks):/tf/notebooks -p 8888:8888 nhorro/tensorflow1.12-py3-jupyter-opencv:latest
```
