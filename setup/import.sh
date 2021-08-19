docker run \
    -e DOWNLOAD_PBF=https://download.geofabrik.de/europe/luxembourg-latest.osm.pbf \
    -e DOWNLOAD_POLY=https://download.geofabrik.de/europe/luxembourg.poly \
    -e PGPASSWORD=1234 \
    -e DATABASE_HOST=192.168.181.224 \
    -e DATABASE_PORT=15433 \
    -e DATABASE_NAME=gis \
    -e DATABASE_USER=postgres \
    -e DATABASE_PASS="example" \
    -v /home/alex/Desktop/tor_data/osm-tile-server-data:/var/lib/postgresql/12/main \
    funreality/osm-ts-importer:latest \
    import