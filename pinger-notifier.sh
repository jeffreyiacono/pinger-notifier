#!/bin/bash

# usage:
#
# ./pinger-notifier.sh url_1 [url_2 ...]
#
# this use https://github.com/jeffreyiacono/pinger and assumes
# it's setup via the command line (see: https://github.com/jeffreyiacono/pinger#usage)

set -e

for url in "$@"; do
  if ! msg=$(pinger $url) ; then

email=$(cat <<EOS
From: You <you@email.com>
To: you@email.com
Subject: pinger alert for $1 @ $(date "+%Y-%m-%d %H:%M:%S")
Content-Type: text/html; charset=utf-8
Content-Disposition: inline;
<p>
  <h2>$url => $msg</h2>
  <p>result from <code>$ pinger $1</code> @ $(date "+%Y-%m-%d %H:%M:%S")</p>
</p>
EOS
)

    echo -e "$email" | /usr/sbin/sendmail -t
  fi
done