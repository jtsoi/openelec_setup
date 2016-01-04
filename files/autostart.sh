#!/bin/sh
(
sleep 10;
/storage/.btsync/btsync --config /storage/.btsync/sync.conf
) &
/storage/.ssh/autossh.sh &
