#!/bin/bash

set -x


if [ "$1" = "run" ]; then
    ./reconfigure_stylesheet.sh
    # Clean /tmp
    rm -rf /tmp/*

    # Configure Apache CORS
    if [ "$ALLOW_CORS" == "enabled" ] || [ "$ALLOW_CORS" == "1" ]; then
        echo "export APACHE_ARGUMENTS='-D ALLOW_CORS'" >> /etc/apache2/envvars
    fi

    service apache2 restart

    # Configure renderd threads
    sed -i -E "s/num_threads=[0-9]+/num_threads=${THREADS:-4}/g" /usr/local/etc/renderd.conf

#    # start cron job to trigger consecutive updates
#    if [ "$UPDATES" = "enabled" ] || [ "$UPDATES" = "1" ]; then
#      /etc/init.d/cron start
#    fi

    # Run while handling docker stop's SIGTERM
    stop_handler() {
        kill -TERM "$child"
    }
    trap stop_handler SIGTERM

    sudo -u renderer renderd -f -c /usr/local/etc/renderd.conf &
    child=$!
    wait "$child"

    exit 0
fi

echo "invalid command"
exit 1