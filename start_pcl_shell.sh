winpty docker run \
    --name pcl_container \
    -it \
    --rm \
    -e DISPLAY=host.docker.internal:0 \
    --mount type=bind,src=$(pwd)/cloud_viewer,dst=/code \
    innerspace/docker-pcl:ubuntu_16.04