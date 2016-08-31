#!/bin/bash

/bin/bash /opt/scripts/bootstrap.sh
/bin/bash /opt/scripts/install-web.sh

/opt/ejudge-build/bin/ejudge-upgrade-web
su ejudge -c "/opt/ejudge-build/bin/ejudge-control start"

/usr/sbin/apache2 -DFOREGROUND
