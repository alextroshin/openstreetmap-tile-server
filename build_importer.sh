set -ex
# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=funreality
# image name
IMAGE=osm-ts-importer
sudo docker build --network=host -t $USERNAME/$IMAGE:latest ./importer