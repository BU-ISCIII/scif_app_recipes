#!/bin/bash
set -e

find /scif/apps -maxdepth 2 -name "bin" | while read in; do echo "export PATH=\${PATH}:$in" >> /opt/path_export ;done
source /opt/path_export

exec "$@"
