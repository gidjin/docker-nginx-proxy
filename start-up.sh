#!/bin/bash

set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:$ETCD_PORT

echo "[nginx] booting container. ETCD: $ETCD."

# Try to make initial configuration every 5 seconds until successful
until confd -onetime -node $ETCD; do
    echo "[nginx] waiting for confd to create initial nginx configuration."
    sleep 5
done

# Put a continual polling `confd` process into the background to watch
# for changes every 300 seconds
confd -interval 10 -node $ETCD > /var/log/confd.log 2>&1 &
echo "[nginx] confd is now monitoring etcd for changes..."

# Start the Nginx service using the generated config
echo "[nginx] starting nginx service..."
service nginx stop
nginx -g "daemon off;"
# CMD ["nginx", "-g", "daemon off;"]

# Follow the logs to allow the script to continue running
# tail -f /var/log/nginx/*.log /var/log/confd.log
