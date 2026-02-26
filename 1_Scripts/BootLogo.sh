#!/bin/sh

##############################################################
# BootLogo Installer - GitHub API Version (Private Repo Safe)
# Developed by BoHLALA
##############################################################

# ضع التوكن الخاص بك هنا
TOKEN="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"

# اسم ملف الإضافة
FILE="BootLogo.tar.gz"

# رابط API لتحميل الملفات الخاصة
API_URL="https://api.github.com/repos/BoHLALA/Ksa/contents/3_Plugins/$FILE?ref=main"

# مكان التخزين المؤقت داخل الجهاز
TMP="/var/volatile/tmp/$FILE"

echo "============================================================="
echo "Downloading $FILE using GitHub API ..."
echo "============================================================="

# تحميل الملف من GitHub API (الطريقة الصحيحة للملفات الخاصة)
wget \
  --header="Authorization: token $TOKEN" \
  --header="Accept: application/vnd.github.v3.raw" \
  -O "$TMP" \
  "$API_URL"

# التحقق من نجاح التحميل
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

        # إعادة تشغيل Enigma2
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
