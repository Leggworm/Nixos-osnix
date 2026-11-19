refuse_installation() {
  printf 'Остановка: %s\n' "$1" >&2
  exit 1
}

[[ $# == 0 && -t 0 ]] || refuse_installation 'Запустите install-leggrowm в терминале без аргументов.'
if (( EUID != 0 )); then
  exec /run/wrappers/bin/sudo -- "$0"
fi
[[ -d /sys/firmware/efi/efivars ]] || refuse_installation 'Загрузите флешку в режиме UEFI.'

inspect_target_disk() {
  local inventory
  inventory=$(lsblk --tree --bytes --json --output PATH,TYPE,TRAN,MODEL,SIZE,RM,RO,MOUNTPOINTS,SERIAL) || return 1
  jq --exit-status --compact-output --arg path "$target_disk" --arg model "$expected_model" '
    def normalize_model: ascii_downcase | gsub("[ _]"; "");
    [.blockdevices[] | select(.type == "disk" and .tran == "nvme")] | select(length == 1) | first
    | select(.path == $path and (.model | normalize_model) == ($model | normalize_model) and (.rm | not) and (.ro | not))
    | select(.size == 512110190592)
    | select([recurse(.children[]?) | .mountpoints[]? | select(. != null)] | length == 0)
    | {path,model,serial,size}' <<<"$inventory"
}

lsblk -d -o PATH,MODEL,SIZE,TRAN
identity=$(inspect_target_disk) || refuse_installation 'Нужен один незанятый внутренний NVMe ожидаемой модели и ёмкости. Ничего не стиралось.'
if findmnt -rn -o TARGET | grep -E '^/mnt(/|$)' >/dev/null; then
  refuse_installation 'В /mnt уже есть смонтированные файловые системы.'
fi
printf 'Будут удалены Windows, Recovery и ВСЕ данные с SSD:\n%s\n' "$identity"
printf 'Для подтверждения введите ERASE %s (Enter без текста отменяет): ' "$target_disk"
IFS= read -r confirmation && [[ $confirmation == "ERASE $target_disk" ]] || refuse_installation 'Установка отменена.'
[[ $(inspect_target_disk) == "$identity" ]] || refuse_installation 'Сведения о диске изменились.'
"$partition_script"
for mount_point in /mnt /mnt/boot; do
  mounted_partition=$(findmnt -n -M "$mount_point" -o SOURCE)
  [[ $(lsblk -dnpo PKNAME "$mounted_partition") == "$target_disk" ]] || refuse_installation "Неожиданный диск для $mount_point."
done
mkdir -p /mnt/etc/nixos
cp -R --no-preserve=mode,ownership "$configuration_source"/. /mnt/etc/nixos/
chmod -R u+w /mnt/etc/nixos
nixos-install --root /mnt --system "$installed_system" --no-root-passwd --no-channel-copy
printf 'Задайте пароль для входа leggrowm. При вводе символы не отображаются.\n'
nixos-enter --root /mnt -c 'passwd leggrowm'
sync
printf 'Готово. Выполните sudo poweroff, извлеките флешку после выключения и включите ноутбук.\n'
