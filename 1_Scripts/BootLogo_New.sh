#!/bin/sh

FILE="BootLogo.tar.gz"
URL="https://www.dropbox.com/scl/fi/wxgobrnsm7et7awrxdnkm/BootLogo.tar.gz?rlkey=8lwde1cta3v3y2l65zhm3d2bh&st=day9fkwb&dl=1"
TMP="/var/volatile/tmp/$FILE"

SEP="#############################################################"

echo "$SEP"
echo "#            Downloading $FILE ...                          #"
echo "$SEP"

wget -O "$TMP" "$URL"

if [ -f "$TMP" ]; then
    echo ""
    echo "$SEP"
    echo "#                 Extracting files ...                      #"
    echo "$SEP"

    tar -xzvf "$TMP" -C /
    RESULT=$?

    rm -f "$TMP"

    if [ $RESULT -eq 0 ]; then
        echo "$SEP"
        echo "#   BootLogo INSTALLED SUCCESSFULLY - By BoHLALA            #"
        echo "$SEP"

        if which systemctl > /dev/null 2>&1; then
            sleep 2; systemctl restart enigma2
        else
            init 4; sleep 4; init 3
        fi
    else
        echo "$SEP"
        echo "#      INSTALLATION FAILED (Extraction Error)               #"
        echo "$SEP"
    fi
else
    echo "$SEP"
    echo "#   DOWNLOAD FAILED (File Not Found or Corrupted)           #"
    echo "$SEP"
fi

