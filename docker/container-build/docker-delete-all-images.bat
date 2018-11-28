:: delete all containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
:: delete all images
docker rmi $(docker images -q)
