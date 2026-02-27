#!/bin/sh

FILE="BootLogo.tar.gz"
URL="https://github.com/BoHLALA/Ksa/releases/download/v1.0.0/BootLogo.tar.gz"
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
        echo "#   BootLogo INSTALLED SUCCESSFULLY - By BoHLALA .. ^_^ #"
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
