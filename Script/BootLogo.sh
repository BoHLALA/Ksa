#!/bin/sh

##############################################################
# BootLogo Installer - Protected Version
# Developed by BoHLALA
##############################################################

# ضع التوكن الخاص بك هنا بين علامتي الاقتباس
TOKEN="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"

# اسم ملف الإضافة
FILE="BootLogo.tar.gz"

# رابط الملف داخل المستودع الخاص Ksa
URL="https://raw.githubusercontent.com/BoHLALA/Ksa/main/Plugins/$FILE"

# مكان التخزين المؤقت داخل الجهاز
TMP="/var/volatile/tmp/$FILE"

echo "============================================================="
echo "Downloading $FILE ..."
echo "============================================================="

# تحميل الملف من المستودع الخاص باستخدام التوكن
wget --header="Authorization: token $TOKEN" -O "$TMP" "$URL"

# التحقق من نجاح التحميل
if [ -f "$TMP" ]; then
    echo ""
    echo "Extracting ..."
    echo "============================================================="

    # فك الضغط بشكل صحيح (الأحرف كلها صغيرة)
    tar -xzvf "$TMP" -C /

    RESULT=$?

    # حذف الملف المؤقت
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
        echo ">>>> INSTALLATION FAILED <<<<"
    fi
else
    echo "Download failed! File not found."
fi
