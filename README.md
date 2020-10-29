# openpose-docker
A docker build file for CMU openpose with Python API support. Tested this on a AMD Laptop with NVIDIA GEFORCE GPU (Nov 2020).

- This should work with any of the NVIDIA latest GPUs.
- This assumes CUDA 10.0 or higher and CuDNN 7.5 or higher.

The original work was bassed on: 
https://hub.docker.com/r/cwaffles/openpose

## Requirements
- Nvidia Docker runtime: https://github.com/NVIDIA/nvidia-docker#quickstart
- CUDA 10.0 or higher on your host, check with `nvidia-smi`
- CuDNN 7.5 or higher on your host.
- A web-camera connected to your host (this assumes /dev/video0 is exported)

## Example
### Get the Dockerfile to your machine. 
`git clone https://github.com/hmurari/openpose-docker.git`
`cd openpose-docker`

### Build container locally
`docker built -t openpose .`

### Use a prebuilt container
`TBD`
 
### Run the container
`docker run --gpus all -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix --ipc=host --device=/dev/video0:/dev/video0 -it openpose:latest /bin/bash`

### Run body keypoints detection from web-cam video
`python3 001_body_from_camera.py`


