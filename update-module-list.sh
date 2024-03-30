#!/bin/bash
DKMS_MODULES_LIST=tbs6522h-modules.list
MODULES_FILE=modules.list

old_checksum=$(sha256sum "$MODULES_FILE" | awk '{print $1}')

i=0

echo "" > $MODULES_FILE

for MODULE in $(cat $DKMS_MODULES_LIST | sort)
do
    echo "BUILT_MODULE_NAME[$i]=\"$MODULE\"" >> $MODULES_FILE
    echo "BUILT_MODULE_LOCATION[$i]=\"media_build/v4l\"" >> $MODULES_FILE
    echo "DEST_MODULE_LOCATION[$i]=\"/updates/tbs\"" >> $MODULES_FILE

    ((i++))
done

new_checksum=$(sha256sum "$MODULES_FILE" | awk '{print $1}')
echo "Setting new sha256sum: $new_checksum."

sed -i "s/'$old_checksum'/'$new_checksum'/" PKGBUILD
