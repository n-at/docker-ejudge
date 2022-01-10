#!/bin/bash

CONTEST_HOME="/home/judges"
EJUDGE_INSTALL="/opt/scripts/install.sh"

chown -R ejudge:ejudge "${CONTEST_HOME}"

if [ "$(ls -A $CONTEST_HOME)" ]; then
    echo "Contest directory is not empty. Leaving."
else
    echo "Installing ejudge..."
    /bin/bash "${EJUDGE_INSTALL}"
fi
