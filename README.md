# tensorflow1.12-py3-jupyter-opencv

Dockerfile from official tensorflow r1.12 GPU/Python3/Jupyter image with some additions: OpenCV, Graphviz, etc.
This image uses Tensorflow 1.12, which is the latest supporting supporting CUDA 9.0.
The purpose of this image is to develop on older machines with GPUs not supporting CUDA 10.0, such as Geforce GTX 950M.

The development docker container is based on official tensorflow 1.12 GPU/Python3 image with some additions:

- Additions:
  - OpenCV
  - requests
  - Graphviz and PyDot (for Keras model diagrams)

Jupyter Notebooks are served from the original directory /tf/notebooks.

## Usage example

Run a jupyter notebook server mounting ./my-notebooks:

```bash
docker run -it --rm --runtime=nvidia -v $(realpath $PWD/my-notebooks):/tf/notebooks --name tensorflowdev1 -p 8888:8888 -p :8501 custom-tensorflow1.12-py3-jupyter-opencv
```