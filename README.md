# openpose-docker
A docker build file for CMU openpose with Python API support. Tested this on a AMD Laptop with NVIDIA GEFORCE GPU (Nov 2020).

This should work with most of the recent NVIDIA latest GPUs.

The original Dockerfile was bassed on:
https://hub.docker.com/r/cwaffles/openpose

## Requirements
- Nvidia Docker runtime: https://github.com/NVIDIA/nvidia-docker#quickstart
- CUDA 10.0 or higher on your host, check with `nvidia-smi`
- CuDNN 7.5 or higher on your host.
- A web-camera connected to your host (this assumes /dev/video0 is exported)

## Example
### Build the Dockerfile locally and run it
```
# Clone the Dockerfile repository
git clone https://github.com/hmurari/openpose-docker.git

# Build Docker container locally
cd openpose-docker
docker built -t openpose .

# Run the Docker container (share display, ipc, webcam with container)
docker run --gpus all -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix --ipc=host --device=/dev/video0:/dev/video0 -it openpose:latest /bin/bash

# Run Openpose body detection from webcam video
python3 001_body_from_camera.py
```

### Run the container from dockerhub.
```
# Pull Docker image
docker pull hmurari/openpose-docker:latest

# Run container
docker run --gpus all -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix --ipc=host --device=/dev/video0:/dev/video0 -it openpose:latest /bin/bash

# Run Openpose body detection from webcam video
python3 001_body_from_camera.py
```




