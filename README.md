# opencv-docker
Dockerfile for OpenCV 3.2 with CUDA enabled 

# Requirements
A CUDA 8.0 capable driver is required.

# Run with GUI
To enable GUI in Docker (e.g. Need to capture and display video in OpenCV), install X Server in host by
```script
sudo apt-get install fxlrg xserver-xorg-core xserver-xorg xorg openbox
```
then enable local access to X server in host by 
```script
xhost +local:root
```
and run the docker using

```script
docker run -it -e="DISPLAY" -e="QT_X11_NO_MITSHM=1" -v="/tmp/.X11-unix:/tmp/.X11-unix:rw" pkdogcom/opencv3.2 bash
```

Refer to http://wiki.ros.org/docker/Tutorials/GUI for more details to enable GUI in Docker.
