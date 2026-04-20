#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/recovery:12576768:99eeaea759626cb05ec14d659f8a27e05b08ba2d; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/boot:11538432:c1514ecea336291150593e9eb2a211531e33069f EMMC:/dev/block/recovery 9050a57f588cee6b483a6e060fde322a0f623121 12574720 c1514ecea336291150593e9eb2a211531e33069f:/system/recovery-from-boot.p && installed=1 && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  [ -n "$installed" ] && dd if=/system/recovery-sig of=/dev/block/recovery bs=1 seek=12574720 && sync && log -t recovery "Install new recovery signature: succeeded" || log -t recovery "Installing new recovery signature: failed"
else
  log -t recovery "Recovery image already installed"
fi
