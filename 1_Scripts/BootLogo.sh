#!/bin/sh

TOKEN="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"

FILE="BootLogo.tar.gz"
API_URL="https://api.github.com/repos/BoHLALA/Ksa/contents/3_Plugins/$FILE?ref=main"
TMP="/var/volatile/tmp/$FILE"

echo "============================================================="
echo "Downloading $FILE using GitHub API ..."
echo "============================================================="

wget \
  --header="Authorization: token $TOKEN" \
  --header="Accept: application/octet-stream" \
  -O "$TMP" \
  "$API_URL"

if [ -f "$TMP" ]; then
    echo ""
    echo "Extracting ..."
    echo "============================================================="

    tar -xzvf "$TMP" -C /
    RESULT=$?

    rm -f "$TMP"

    if [ $RESULT -eq 0 ]; then
        echo "#############################################################"
        echo "#     BootLogo INSTALLED SUCCESSFULLY - By BoHLALA          #"
        echo "#############################################################"

        if which systemctl > /dev/null 2>&1; then
            sleep 2; systemctl restart enigma2
        else
            init 4; sleep 4; init 3
        fi
    else
        echo ">>>> INSTALLATION FAILED (Extraction Error) <<<<"
    fi
else
    echo ">>>> DOWNLOAD FAILED (File Not Found or Corrupted) <<<<"
fi
