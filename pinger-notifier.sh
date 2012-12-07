#!/bin/bash

# Usage:
#
# ./pinger-notifier.sh [email-from] [email-to] [url_1 (url_2 ... etc.)]
#
# uses https://github.com/jeffreyiacono/pinger and assumes
# it's in PATH (see: https://github.com/jeffreyiacono/pinger#usage)

set -e

DATE_FORMAT="+%Y-%m-%d %H:%M:%S"

function usage {
  echo "Usage: $0 [email-from] [email-to] [url_1 (url_2 ... etc.)]"
}

if [ "$1" == "-h" ] ; then
  usage
  exit 0
elif [ "$1" == "-v" ] ; then
  echo "version 1.0"
  exit 0
elif [ $# -lt 3 ] ; then
  echo -n "Error: who the email should be from, must pass who to email, "
  echo    "and at least 1 URL to ping."
  echo    ""
  usage
  exit 1
fi

from=$1
to=$2

# pop off first 2 args (from / to) => rest are urls
# may be a way to handle this via the url for loop below
# which would make this unnecessary
for (( i=0 ; i < 2 ; i++ )) ; do shift ; done

for url in "$@" ; do
  if ! msg=$(pinger $url) ; then

    email=$(cat <<EOS
From: $from
To: $to
Subject: pinger alert for $url @ $(date "$DATE_FORMAT")
Content-Type: text/html; charset=utf-8
Content-Disposition: inline;
<p>
  <h2>$url => $msg</h2>
  <p>result from <code>$ pinger $url</code> @ $(date "$DATE_FORMAT")</p>
</p>
EOS
    )

    echo -e "$email" | /usr/sbin/sendmail -t
  fi
done
