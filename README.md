# Docker PCL test

Example of visualizing a point cloud using Docker container with Point Cloud Library (PCL). 
This repo is to a large extent a Windows/Mac version of the [example](https://hub.docker.com/r/svponomarev/pcl_trunk/) by 
[svponomarev](https://github.com/svponomarev).

## Getting Started
### Prerequisites
* **git** - tool to download this repository on your pc and keep it updated
* **docker** - tool to download and run the Docker container containing PCL and all its 3rd party libraries 
* **VcXsrv Windows X Server** (if using Windows) or **xQuartz** (if using MacOS) in order to get Docker container to display 
graphics (No extra servers required for Linux, check this 
[Running Docker with GUI guide](https://cuneyt.aliustaoglu.biz/en/running-gui-applications-in-docker-on-windows-linux-mac-hosts/) 
for all 3 OS)

### Clone this repository to your PC
Download this folder or clone the repo using git from your terminal:
```
git clone https://github.com/mihsamusev/docker_pcl_test.git
```
### Getting Docker PCL image
Pull [innerspace PCL image](https://hub.docker.com/r/innerspace/docker-pcl) from docker hub.
The image is quite heavy (1.12 GB) due to the large amount and weight of the 3rd party libraries required to run PCL.
```
docker pull innerspace/docker-pcl
```

### Run the container
If you are on Windows start the container by running ``./start_pcl_container.sh`` shell script. The script tells docker to run the
container in the interactive mode, provide access to host graphics from container through DISPLAY environmental variable, mount volume
allowing file exchange between /cloud_viewer directory on the host and /code directory on the container. Finally, the container is going
to be removed after exiting to free storage. **Make sure VcXsrv or xQuartz are up and running otherwise the container is unable display graphics.**
```
docker run \
    --name pcl_container \
    -it \
    --rm \
    -e DISPLAY=host.docker.internal:0 \
    --mount type=bind,src=$(pwd)\\cloud_viewer,dst=/code \
    innerspace/docker-pcl:ubuntu_16.04
```
The container can be exited using **ctrl + d** or writting ``exit`` to the provided container terminal.

## Very first run
During the very first run one should build and compile ``cloud_viewer`` C/C++ project. In the following 5 step example we build and compile the project in
the ``/code/build`` folder inside the container. 
```
cd /code
mkdir build
cd build
cmake ..
make
```

Among other CMake related folders and files the ``/code/build`` shoud now contain ``cloud_viewer.exe`` - our app that is used to preview
the ``bunny.pcd`` point cloud, a sphere and some text inside GUI.

## After first run and all next times
If the project is built, one can run the ``cloud_viewer.exe`` application. Its best done from the ``/code`` folder because used point cloud data
stored in ``bunny.pcd`` file resides in the ``/code`` folder.

```
./build/cloud_viewer
```

## Results
If everything is correct one should arrive at a new window with interactive point cloud viewer. 
![alt text](https://github.com/mihsamusev/docker_pcl_test/result.PNG "Cloud bunny from Docker PCL")
Following useful commands can be applied to operate the viewer 
* ``+\-`` increase / decrease point size
* ``r`` reset camera to viewpoint (0, 0, 0)
* ``p``, ``w`` or ``s`` switch between point, wireframe or surface representation of objects made of triangles 
* ``q`` stop and terminate viewer
* ``h`` print full list of commands to the terminal

