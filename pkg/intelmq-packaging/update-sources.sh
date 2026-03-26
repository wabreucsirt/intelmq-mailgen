#!/bin/bash

echo 'deb [signed-by=/etc/apt/trusted.gpg.d/nodesource.asc] https://deb.nodesource.com/node_14.x jammy main' \
     >/etc/apt/sources.list.d/nodesource.list
# https://github.com/nodesource/distributions/issues/1912
#wget -O /etc/apt/trusted.gpg.d/nodesource.asc https://deb.nodesource.com/gpgkey/nodesource.gpg.key
wget -O /etc/apt/trusted.gpg.d/nodesource.asc "https://pubkeys.intevation.de/pks/lookup?op=get&search=0x9fd3b784bc1c6fc31a8a0a1c1655a0ab68576280"

echo "deb [signed-by=/etc/apt/trusted.gpg.d/sebix.asc] http://download.opensuse.org/repositories/home:/sebix:/intelmq/xUbuntu_22.04/ /" > /etc/apt/sources.list.d/intelmq.list
wget -O /etc/apt/trusted.gpg.d/sebix.asc https://download.opensuse.org/repositories/home:sebix:intelmq/xUbuntu_22.04/Release.key

echo "deb [signed-by=/etc/apt/trusted.gpg.d/yarn.asc] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
wget -O /etc/apt/trusted.gpg.d/yarn.asc https://dl.yarnpkg.com/debian/pubkey.gpg
