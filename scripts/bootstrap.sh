#!/bin/bash

CONTEST_HOME="/home/ejudge"
EJUDGE_INSTALL="/opt/scripts/install.sh"

chown -R ejudge:ejudge "${CONTEST_HOME}"

if [ "$(ls -A $CONTEST_HOME)" ]; then
    echo "Contest directory is not empty. Leaving."
else
    echo "Installing ejudge..."
    chmod +x "${EJUDGE_INSTALL}"
    "${EJUDGE_INSTALL}"
fi
