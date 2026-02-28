#!/bin/sh

URL="https://github.com/BoHLALA/Ksa/releases/download/BootLogo_v1/BootLogo.tar.gz"
FILE="/tmp/BootLogo.tar.gz"

echo "Downloading BootLogo..."
rm -f "$FILE"

wget "$URL" -O "$FILE"

if [ -s "$FILE" ]; then
    echo "Extracting..."
    tar -xzvf "$FILE" -C /
    rm -f "$FILE"

    echo "BootLogo installed successfully."
    echo "By: قــدام (BoHLALA)"

    if which systemctl > /dev/null 2>&1; then
        sleep 2; systemctl restart enigma2
    else
        init 4; sleep 4; init 3
    fi
else
    echo "Download failed or file is empty."
fi
