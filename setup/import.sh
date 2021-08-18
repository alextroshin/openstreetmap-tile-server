docker run \
    -e DOWNLOAD_PBF=https://download.geofabrik.de/europe/luxembourg-latest.osm.pbf \
    -e DOWNLOAD_POLY=https://download.geofabrik.de/europe/luxembourg.poly \
    -v /home/alex/Desktop/tor_data/osm-tile-server-data:/var/lib/postgresql/12/main \
    funreality/openstreetmap-tile-server:latest \
    import