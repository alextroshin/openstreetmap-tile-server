#!/bin/bash
set -x

if [ "$1" = "import" ]; then


    # Download Luxembourg as sample if no data is provided
    if [ ! -f /data.osm.pbf ] && [ -z "$DOWNLOAD_PBF" ]; then
        echo "WARNING: No import file at /data.osm.pbf, so importing Luxembourg as example..."
        DOWNLOAD_PBF="https://download.geofabrik.de/europe/luxembourg-latest.osm.pbf"
        DOWNLOAD_POLY="https://download.geofabrik.de/europe/luxembourg.poly"
    fi

    if [ -n "$DOWNLOAD_PBF" ]; then
        echo "INFO: Download PBF file: $DOWNLOAD_PBF"
        wget "$WGET_ARGS" "$DOWNLOAD_PBF" -O /data.osm.pbf
        if [ -n "$DOWNLOAD_POLY" ]; then
            echo "INFO: Download PBF-POLY file: $DOWNLOAD_POLY"
            wget "$WGET_ARGS" "$DOWNLOAD_POLY" -O /data.poly
        fi
    fi

    # copy polygon file if available
    if [ -f /data.poly ]; then
        sudo -u renderer cp /data.poly /var/lib/mod_tile/data.poly
    fi

    # Import data
    sudo -u ${DATABASE_USER} PGPASSWORD=${DATABASE_PASS} osm2pgsql -H ${DATABASE_HOST} -P ${DATABASE_PORT} -d ${DATABASE_NAME} --create --slim -G --hstore --tag-transform-script /home/renderer/src/openstreetmap-carto/openstreetmap-carto.lua --number-processes ${THREADS:-4} -S /home/renderer/src/openstreetmap-carto/openstreetmap-carto.style /data.osm.pbf ${OSM2PGSQL_EXTRA_ARGS}

    # Create indexes
    sudo -u ${DATABASE_USER} PGPASSWORD=${DATABASE_PASS} psql -h ${DATABASE_HOST} -p ${DATABASE_PORT} -d ${DATABASE_NAME} -f /home/renderer/src/openstreetmap-carto/indexes.sql

    #Import external data
    ./patch_external_data.sh
    sudo chown -R renderer: /home/renderer/src
    sudo -u renderer python3 /home/renderer/src/openstreetmap-carto/scripts/get-external-data.py -c /external-data_patched.yml -D /home/renderer/src/openstreetmap-carto/data

    exit 0
fi


echo "invalid command"
exit 1