#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/recovery:15259648:81c2a295f02d8c63699b3cbd3754e718792cf6ce; then
  applypatch  EMMC:/dev/block/boot:9383936:001060c3533c6e6053c2ac2d9ea24dcae7b00444 EMMC:/dev/block/recovery bebdb9fbfba071c16ffa5de4b82cd4e837445f79 15257600 001060c3533c6e6053c2ac2d9ea24dcae7b00444:/system/recovery-from-boot.p && installed=1 && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  [ -n "$installed" ] && dd if=/system/recovery-sig of=/dev/block/recovery bs=1 seek=15257600 && sync && log -t recovery "Install new recovery signature: succeeded" || log -t recovery "Installing new recovery signature: failed"
else
  log -t recovery "Recovery image already installed"
fi
