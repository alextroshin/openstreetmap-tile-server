docker run \
    -e DOWNLOAD_PBF=https://download.geofabrik.de/europe/luxembourg-latest.osm.pbf \
    -e DOWNLOAD_POLY=https://download.geofabrik.de/europe/luxembourg.poly \
    -e PGPASSWORD=1234 \
    -v /home/alex/Desktop/tor_data/osm-tile-server-data:/var/lib/postgresql/12/main \
    funreality/osm-ts-importer:latest \
    import