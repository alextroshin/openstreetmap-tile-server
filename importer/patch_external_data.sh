#!/bin/bash

sed -e "s/\${DATABASE_HOST}/$DATABASE_HOST/" -e "s/\${DATABASE_PORT}/$DATABASE_PORT/" \
-e "s/\${DATABASE_USER}/$DATABASE_USER/" -e "s/\${DATABASE_PASS}/$DATABASE_PASS/" \
-e "s/\${DATABASE_NAME}/$DATABASE_NAME/" /external-data.yml > /external-data_patched.yml