#!/bin/bash

#
# Укажите ниже пути к:
PRESEED_FILE=./preseed.cfg #$1
INPUT_ISO=/storage/iso/debian11.iso #$2
OUTPUT_ISO=/storage/iso/auto_debian11.iso #$3

echo "preseed.cfg IS: $PRESEED_FILE"
echo "input iso   IS: $INPUT_ISO"
echo "output iso  IS: $OUTPUT_ISO"

TEMP_DIR=$(mktemp -d);
cat $INPUT_ISO | bsdtar -C $TEMP_DIR -xf - \
   && echo "Исходный образ распакован! Модификация образа.."
chmod -R +w $TEMP_DIR
cp -R extra $TEMP_DIR      && echo "Экстра пакеты добавлены в образ!"
cp $PRESEED_FILE $TEMP_DIR && echo "preseed.cfg добавлен в образ!"
sed -i '1s/^/DEFAULT install\n/' $TEMP_DIR/isolinux/txt.cfg
sed -i '1s/^/PROMPT 0\n/' $TEMP_DIR/isolinux/txt.cfg
sed -i '/append/ s/$/ priority=high locale=en_GB\.UTF-8 keymap=gb file=\/cdrom\/preseed.cfg/' $TEMP_DIR/isolinux/txt.cfg
cp $TEMP_DIR/isolinux/txt.cfg $TEMP_DIR/isolinux/isolinux.cfg && echo "Образ успешно модифицирован! Сборка.."

genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat \
            -no-emul-boot -boot-load-size 4 -boot-info-table \
            -o $OUTPUT_ISO $TEMP_DIR \
            && echo "Образ успешно собран: $OUTPUT_ISO"