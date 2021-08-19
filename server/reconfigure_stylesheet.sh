#!/bin/bash

sed -e "s/\${DATABASE_HOST}/$DATABASE_HOST/" -e "s/\${DATABASE_PORT}/$DATABASE_PORT/" \
-e "s/\${DATABASE_USER}/$DATABASE_USER/" -e "s/\${DATABASE_PASS}/$DATABASE_PASS/" \
-e "s/\${DATABASE_NAME}/$DATABASE_NAME/" /project.mml > /project_formatted.mml

cat /project_formatted.mml > /home/renderer/src/openstreetmap-carto/project.mml
carto /home/renderer/src/openstreetmap-carto/project.mml > /home/renderer/src/openstreetmap-carto/mapnik.xml