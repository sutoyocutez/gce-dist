#!/bin/bash

# Setup Environment Variables
export PATH=/container/dist/bin:/container/dist/sbin:$PATH
export LD_LIBRARY_PATH=/container/dist/lib/x86_64-linux-gnu

echo "export PATH=/container/dist/bin:/container/dist/sbin:$PATH" >> /root/.bashrc
echo "export DIST_DIR=/container/dist" >> /root/.bashrc
echo "export ETC_DIR=/container/dist/etc" >> /root/.bashrc
echo "export LD_LIBRARY_PATH=/container/dist/lib/x86_64-linux-gnu"

BACKUP_FILENAME=server-dist.7z
cd /content
echo "Downloading base system ${BACKUP_FILENAME}"

# replace file id with yours
FILE_ID="1-W0v2tS8-AU0WgUUHdxNr_EQAmGb6cn5"
gdown $FILE_ID

mkdir -p /container/dist
mkdir -p /container/src
 
cd /container/dist

7z x /content/$BACKUP_FILENAME

# Starting gotty webshell
WEBSHELL_PORT=1986
gotty -w --port $WEBSHELL_PORT /bin/bash&

# Starting bore tunnel for port gotty web shell on port 1986
bore local $WEBSHELL_PORT --to=bore.pub
