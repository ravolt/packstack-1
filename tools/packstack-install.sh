#!/bin/bash
#
# Copyright 2014, Greg Althaus
#

#
# Make sure the opencrowbar is installed
#
wget --no-check-certificate -O - https://raw.githubusercontent.com/opencrowbar/core/master/tools/crowbar-install.sh | source /dev/stdin $@ 2>&1 >/tmp/saved.output

# Setup RackN public repo
cd /etc/yum.repos.d
cat > rackn_public.repo <<EOF
[ocb]
name=repo for rackn public rpms
baseurl=https://s3.amazonaws.com/rackn/public/el6
enabled=1
gpgcheck=0
type=none
autorefresh=1
keeppackages=1
EOF

cd -

# Clean up repos
yum clean all
yum makecache

# Install code
yum install -y rackn-packstack

cat /tmp/saved.output
rm /tmp/saved.output