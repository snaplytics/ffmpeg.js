docker build -t build_image .

if [ "$(docker ps -aqs -f name=build_container)" ]; then
  docker rm -f build_container
fi

docker run --name build_container build_image