#!/bin/bash

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/master" "/var/www/ejudge/cgi-bin/master"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/master" "/var/www/ejudge/cgi-bin/master"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/judge" "/var/www/ejudge/cgi-bin/judge"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/judge" "/var/www/ejudge/cgi-bin/judge"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/team" "/var/www/ejudge/cgi-bin/team"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/team" "/var/www/ejudge/cgi-bin/team"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/register" "/var/www/ejudge/cgi-bin/register"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/register" "/var/www/ejudge/cgi-bin/register"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/users" "/var/www/ejudge/cgi-bin/users"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/users" "/var/www/ejudge/cgi-bin/users"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/serve-control" "/var/www/ejudge/cgi-bin/serve-control"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/serve-control" "/var/www/ejudge/cgi-bin/serve-control"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/new-client" "/var/www/ejudge/cgi-bin/new-client"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/new-client" "/var/www/ejudge/cgi-bin/new-client"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/new-master" "/var/www/ejudge/cgi-bin/new-master"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/new-master" "/var/www/ejudge/cgi-bin/new-master"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/new-judge" "/var/www/ejudge/cgi-bin/new-judge"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/new-judge" "/var/www/ejudge/cgi-bin/new-judge"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/new-register" "/var/www/ejudge/cgi-bin/new-register"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/libexec/ejudge/cgi-bin/new-register" "/var/www/ejudge/cgi-bin/new-register"' >&2
  exit 1
fi

install -d -m 02775 -g "ejudge" -o "ejudge" "/var/www/ejudge/htdocs/ejudge"
if [ $? != 0 ]
then
  echo "creation of /var/www/ejudge/htdocs/ejudge failed" 2>&1
  exit 1
fi

ln -sf "/opt/ejudge-build/share/ejudge/style/logo.gif" "/var/www/ejudge/htdocs/ejudge/logo.gif"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/share/ejudge/style/logo.gif" "/var/www/ejudge/htdocs/ejudge/logo.gif"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/share/ejudge/style/priv.css" "/var/www/ejudge/htdocs/ejudge/priv.css"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/share/ejudge/style/priv.css" "/var/www/ejudge/htdocs/ejudge/priv.css"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/share/ejudge/style/priv.js" "/var/www/ejudge/htdocs/ejudge/priv.js"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/share/ejudge/style/priv.js" "/var/www/ejudge/htdocs/ejudge/priv.js"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/share/ejudge/style/unpriv.css" "/var/www/ejudge/htdocs/ejudge/unpriv.css"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/share/ejudge/style/unpriv.css" "/var/www/ejudge/htdocs/ejudge/unpriv.css"' >&2
  exit 1
fi

ln -sf "/opt/ejudge-build/share/ejudge/style/unpriv.js" "/var/www/ejudge/htdocs/ejudge/unpriv.js"
if [ $? != 0 ]
then
  echo 'Command failed: ln -sf "/opt/ejudge-build/share/ejudge/style/unpriv.js" "/var/www/ejudge/htdocs/ejudge/unpriv.js"' >&2
  exit 1
fi
